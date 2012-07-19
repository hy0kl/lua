#include <stdio.h>
#include <stdlib.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

#define BUFF_LEN    1024

/* gcc lua_ext.c -llua -lm -ldl */

static void print_prompt()
{
    printf("lua prompt>> ");
}

int main (int argc, char *argv[])
{
    char buff[BUFF_LEN] = {0};
    int error;

    lua_State *L = luaL_newstate(); /* opens Lua */
    luaL_openlibs(L);   /** Opens all standard Lua libraries into the given state. */

    print_prompt();
    while (fgets(buff, sizeof(buff), stdin) != NULL)
    {
        error = luaL_loadbuffer(L, buff, strlen(buff), "line") || lua_pcall(L, 0, 0, 0);

        if (error)
        {
            fprintf(stderr, "%s", lua_tostring(L, -1));
            lua_pop(L, 1);  /* pop error message from the stack */
        }

        print_prompt();
    }

    lua_close(L);

    return 0;
}

