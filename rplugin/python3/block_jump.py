from __future__ import annotations
import pynvim


from pynvim.api.nvim import Nvim
from pynvim.api.window import Window
from pynvim.api.buffer import Buffer

from typing import (
        # Optional,
        Iterator,
        Final,
        Callable
)

from functools import lru_cache

MAX_FILE_BUFFER: Final[int] = 32


def write_to_log(text: str):
    # with open(LOG_FILE, 'a') as f:
    #     f.write(text + '\n')
    pass


class StartOfBuffer(Exception):
    pass


class EndOfBuffer(Exception):
    pass


class NeoPosition:
    _neo_line_index: int
    _neo_char_index: int

    def __init__(self, py_line_index: int, py_char_index: int):
        self._neo_line_index = py_line_index + 1
        self._neo_char_index = py_char_index

    @classmethod
    def from_window(cls, window: Window) -> NeoPosition:
        c_l: int
        c_ch: int
        c_l, c_ch = window.cursor
        c_l -= 1
        return cls(c_l, c_ch)

    @property
    def position(self) -> tuple[int, int]:
        return self._neo_line_index - 1, self._neo_char_index

    @position.setter
    def position(self, pos: tuple[int, int]):
        self._neo_line_index = pos[0] + 1
        self._neo_char_index = pos[1]

    def set_cursor(self, window: Window):
        window.cursor = (self._neo_line_index, self._neo_char_index)

    def __repr__(self):
        pos = self.position
        return (f"<{self.__class__.__name__}: PyIdx ({pos[0]},  {pos[1]})"
                + f" NvimIdx ({self._neo_line_index}, "
                + f" {self._neo_char_index})>")


class LinearFile:
    _explorer: Explorer

    def __init__(self, explorer: Explorer):
        pass


class Explorer:
    _line_length_cache: dict[int, int]

    _window: Window
    _buffer: Buffer
    _cursor: NeoPosition
    _buffer_lines: Callable[[int], str]
    _line_number: int

    def __init__(self, nvim: Nvim):
        self._window = nvim.current.window
        self._buffer = nvim.current.window.buffer
        self._cursor = NeoPosition.from_window(self._window)
        self._line_number = len(self._buffer)
        self._line_length_cache = dict()

        @lru_cache(MAX_FILE_BUFFER)
        def _fetch_lines(line_index: int) -> str:
            return self._buffer[line_index]

        self._buffer_lines = _fetch_lines

    @property
    def cursor(self) -> NeoPosition:
        return self._cursor

    def push_cursor_forward_on_line(self, pos: NeoPosition) -> None:
        pos = pos.position
        self.cursor = NeoPosition(pos[0], pos[1] + 1)

    @cursor.setter
    def cursor(self, pos: NeoPosition) -> None:
        pos.set_cursor(self._window)
        self._cursor = pos

    def get_line(self, line_index: int) -> str:
        return self._buffer_lines(line_index)

    def get_line_length(self, line_index: int) -> int:
        if line_index in self._line_length_cache:
            return self._line_length_cache[line_index]
        else:
            _len = len(self.get_line(line_index))
            self._line_length_cache[line_index] = _len
            return _len

    def on_empty_line(self, pos: NeoPosition) -> bool:
        if self.get_line(pos.position[0]):
            return False
        return True

    def on_end_of_line(self, pos: NeoPosition) -> bool:
        pos = pos.position
        if self.get_line_length(pos[0]) == pos[1]:
            return True
        return False

    def move_to_prior_char(self, pos: NeoPosition) -> NeoPosition:
        pos = pos.position
        if pos == (0, 0):
            raise StartOfBuffer
        if pos[1] != 0:
            return NeoPosition(pos[0], pos[1] - 1)
        else:
            while pos[1] == 0 and pos[0] > 0:
                last_line = self.get_line_length(pos[0] - 1)
                pos = pos[0] - 1, last_line
            else:
                return NeoPosition(pos[0], pos[1] - 1)  # decrement in bounds

    def move_to_next_char(self, pos: NeoPosition) -> NeoPosition:
        pos = pos.position
        if pos[1] + 1 < self.get_line_length(pos[0]):
            return NeoPosition(pos[0], pos[1] + 1)
        else:
            pos = pos[0] + 1, 0
            while pos[0] < self._line_number:
                if self.get_line(pos[0]):
                    return NeoPosition(*pos)
                pos = pos[0] + 1, 0
            raise EndOfBuffer

    def get_char(self, pos: NeoPosition) -> str:
        pos = pos.position
        if (pos[0] >= self._line_number or
                pos[1] >= self.get_line_length(pos[0])):
            raise IndexError(f"{pos[0], pos[1]} excedes"
                             + f" line numbers ({self._line_number}) or"
                             + " characters in line"
                             + f" ({self.get_line_length(pos[0])})")
        else:
            return self.get_line(pos[0])[pos[1]]

    def travel_back(self, inital_position: NeoPosition, offset: int = 0
                    ) -> Iterator[tuple[str, NeoPosition]]:
        pos = inital_position
        # write_to_log(f"Travel Back  start at {pos.position}")
        if offset == 0:
            yield self.get_char(inital_position), inital_position
        else:
            offset -= 1
        for i in range(offset):
            try:
                pos = self.move_to_prior_char(pos)
            except StartOfBuffer:
                break
        else:
            while True:
                try:
                    pos = self.move_to_prior_char(pos)
                except StartOfBuffer:
                    break
                yield self.get_char(pos), pos

    def travel_forward(self, inital_position: NeoPosition, offset: int = 0
                       ) -> Iterator[tuple[str, NeoPosition]]:
        pos = inital_position
        if offset == 0:
            yield self.get_char(inital_position), inital_position
        else:
            offset -= 1
        for i in range(offset):
            try:
                pos = self.move_to_next_char(pos)
            except EndOfBuffer:
                break
        else:
            while True:
                try:
                    pos = self.move_to_next_char(pos)
                except EndOfBuffer:
                    break
                yield self.get_char(pos), pos


OPEN: Final[frozenset[str]] = frozenset(['{', '(', '['])
CLOSE: Final[frozenset[str]] = frozenset(['}', ')', ']'])

PAIRINGS: Final[dict[str, str]] = {
    '{': '}',
    '(': ')',
    '[': ']',
    '}': '{',
    ')': '(',
    ']': '['
}

LOG_FILE: Final[str] = '/home/bsopp/endblock.log'


@pynvim.plugin
class MyPlugin(object):
    def __init__(self, nvim: Nvim):
        self.nvim: Nvim = nvim

    @pynvim.command('FrontBlock', nargs='*', sync=True)
    def front_block_command(self, args):
        explorer = Explorer(self.nvim)
        cursor = explorer.cursor
        offset = 1
        stack: list[str] = []
        if explorer.on_end_of_line(cursor):
            try:
                cursor = explorer.move_to_prior_char(cursor)
                offset = 0
            except StartOfBuffer:
                return
        if (not explorer.on_empty_line(cursor)
                and explorer.get_char(cursor) in OPEN):
            explorer.cursor = cursor
            return
        for char, new_pos in explorer.travel_back(cursor, offset):
            # write_to_log(
            #         f"{repr(stack)}\n" +
            #         f"{repr(char):>3} {new_pos.position})"
            # )
            if char in CLOSE:
                stack.append(char)
            elif char in OPEN:
                if not stack:
                    # write_to_log("Complete - {new_pos.pos}")
                    explorer.cursor = new_pos
                    return
                elif PAIRINGS[stack[-1]] == char:
                    stack.pop()

    @pynvim.command('StartBlock', nargs='*', sync=True)
    def start_block_command(self, args):
        explorer = Explorer(self.nvim)
        cursor = explorer.cursor
        offset = 1
        stack: list[str] = []
        if explorer.on_end_of_line(cursor):
            try:
                cursor = explorer.move_to_prior_char(cursor)
                offset = 0
            except StartOfBuffer:
                return
        if (not explorer.on_empty_line(cursor)
                and explorer.get_char(cursor) in OPEN):
            explorer.push_cursor_forward_on_line(cursor)
            return
        for char, new_pos in explorer.travel_back(cursor, offset):
            # write_to_log(
            #         f"{repr(stack)}\n" +
            #         f"{repr(char):>3} {new_pos.position})"
            # )
            if char in CLOSE:
                stack.append(char)
            elif char in OPEN:
                if not stack:
                    # write_to_log("Complete - {new_pos.pos}")
                    explorer.push_cursor_forward_on_line(new_pos)
                    return
                elif PAIRINGS[stack[-1]] == char:
                    stack.pop()

    @pynvim.command('PriorBlock', nargs='*', sync=True)
    def prior_block_command(self, args):
        explorer = Explorer(self.nvim)
        cursor = explorer.cursor
        offset = 1
        found_start = False
        stack: list[str] = []
        if explorer.on_end_of_line(cursor):
            try:
                cursor = explorer.move_to_prior_char(cursor)
                offset = 0
            except StartOfBuffer:
                return
        if (not explorer.on_empty_line(cursor)
                and explorer.get_char(cursor) in OPEN):
            found_start = True
        for char, new_pos in explorer.travel_back(cursor, offset):
            if char in CLOSE:
                stack.append(char)
            elif char in OPEN:
                if not stack:
                    found_start = True
                elif PAIRINGS[stack[-1]] == char:
                    stack.pop()
                    if not stack and found_start:
                        explorer.push_cursor_forward_on_line(new_pos)
                        return

    @pynvim.command('OuterBlock', nargs='*', sync=True)
    def outer_block_command(self, args):
        explorer = Explorer(self.nvim)
        cursor = explorer.cursor
        offset = 1
        found_start = False
        stack: list[str] = []
        write_to_log(f"OUTERBLOCK: {cursor.position} Inital Position")
        write_to_log("Cursor starts on end-of-line"
                     + f" {explorer.on_end_of_line(cursor)}")
        if explorer.on_end_of_line(cursor):
            try:
                cursor = explorer.move_to_prior_char(cursor)
                offset = 0
            except StartOfBuffer:
                return
        if (not explorer.on_empty_line(cursor)
                and explorer.get_char(cursor) in OPEN):
            offset = 1
            found_start = True
        for char, new_pos in explorer.travel_back(cursor, offset):
            write_to_log(
                    f"{repr(stack)}\n" +
                    f"{repr(char):>3} {new_pos.position})"
            )
            if char in CLOSE:
                stack.append(char)
            elif char in OPEN:
                if not stack:
                    if found_start:
                        explorer.push_cursor_forward_on_line(new_pos)
                        return
                    found_start = True
                elif PAIRINGS[stack[-1]] == char:
                    stack.pop()

    @pynvim.command('InnerBlock', nargs='*', sync=True)
    def innner_block_command(self, args):
        explorer = Explorer(self.nvim)
        cursor = explorer.cursor
        if explorer.on_end_of_line(cursor):
            try:
                cursor = explorer.move_to_next_char(cursor)
            except EndOfBuffer:
                return
        for char, new_pos in explorer.travel_forward(cursor):
            if char in OPEN:
                explorer.push_cursor_forward_on_line(new_pos)
                return

    @pynvim.command('EndBlock', nargs='*', sync=True)
    def end_block_command(self, args):
        explorer = Explorer(self.nvim)
        cursor = explorer.cursor
        stack: list[str] = []
        offset = 1
        if explorer.on_end_of_line(cursor):
            try:
                cursor = explorer.move_to_next_char(cursor)
                offset = 0
            except EndOfBuffer:
                return
        if (not explorer.on_empty_line(cursor)
                and explorer.get_char(cursor) in CLOSE):
            explorer.cursor = cursor
            return
        for char, new_pos in explorer.travel_forward(cursor, offset):
            if char in OPEN:
                stack.append(char)
            elif char in CLOSE:
                if not stack:
                    explorer.cursor = new_pos
                    return
                elif PAIRINGS[stack[-1]] == char:
                    stack.pop()

    @pynvim.command('NextBlock', nargs='*', sync=True)
    def next_block_command(self, args):
        explorer = Explorer(self.nvim)
        cursor = explorer.cursor
        stack: list[str] = []
        offset = 1
        found_end = False
        if explorer.on_end_of_line(cursor):
            try:
                cursor = explorer.move_to_next_char(cursor)
                offset = 0
            except EndOfBuffer:
                return
        if (not explorer.on_empty_line(cursor)
                and explorer.get_char(cursor) in CLOSE):
            found_end = True
        for char, new_pos in explorer.travel_forward(cursor, offset):
            if char in OPEN:
                if found_end:
                    explorer.push_cursor_forward_on_line(new_pos)
                    return
                stack.append(char)
            elif char in CLOSE:
                if not stack:
                    found_end = True
                elif PAIRINGS[stack[-1]] == char:
                    stack.pop()

    @pynvim.command('BackBlock', nargs='*', sync=True)
    def back_block_command(self, args):
        explorer = Explorer(self.nvim)
        cursor = explorer.cursor
        stack: list[str] = []
        offset = 1
        # write_to_log(f"{cursor.position} Inital Position")
        # write_to_log("Cursor does on end-of-line"
        #              + f" {explorer.on_end_of_line(cursor)}")
        if explorer.on_end_of_line(cursor):
            try:
                cursor = explorer.move_to_next_char(cursor)
                offset = 0
            except EndOfBuffer:
                return
        if (not explorer.on_empty_line(cursor)
                and explorer.get_char(cursor) in CLOSE):
            # write_to_log(f"Cursor {cursor.position} on"
            #              + f"{explorer.get_char(cursor)}")
            return explorer.push_cursor_forward_on_line(cursor)
        for char, new_pos in explorer.travel_forward(cursor, offset):
            # write_to_log(
            #         f"{repr(stack)}\n" +
            #         f"{repr(char):>3} {new_pos.position})"
            # )
            if char in OPEN:
                stack.append(char)
            elif char in CLOSE:
                if not stack:
                    # write_to_log(f"Complete - {new_pos.position}")
                    explorer.push_cursor_forward_on_line(new_pos)
                    return
                elif PAIRINGS[stack[-1]] == char:
                    stack.pop()
