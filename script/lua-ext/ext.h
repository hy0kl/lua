#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

#define BUFF_LEN    1024

/* gcc *.c -llua -lm -ldl */
/**
 * lua: _VERSION 5.2
 * */

#define TESTING 1
#define SEPARATOR "    "

void ext_error(lua_State *L)
{
    fprintf(stderr, "%s\n", lua_tostring(L, -1));
    /** pop error message from the stack */
    lua_pop(L, 1);

    return;
}
