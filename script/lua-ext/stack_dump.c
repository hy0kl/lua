#include "ext.h"

static void stack_dump(lua_State *L)
{
    int i;
    int t;
    int top = lua_gettop(L);

    printf("stack dump:\n{\n");

    for (i = 1; i <= top; i++)
    {
        printf("%s", SEPARATOR);

        t = lua_type(L, i);
        /** LUA_TTABLE, LUA_TFUNCTION, LUA_TUSERDATA, LUA_TTHREAD */
        switch (t)
        {
        case LUA_TSTRING:   /** strings */
            printf("string: %s", lua_tostring(L, i));
            break;

        case LUA_TBOOLEAN:  /** booleans */
            printf("bool: %s", lua_toboolean(L, i) ? "true" : "false");
            break;

        case LUA_TNUMBER:   /** numbers */
            printf("number: %g", (double)lua_tonumber(L, i));
            break;

        case LUA_TNIL:      /** nil */
            printf("nil");
            break;

        default:    /** other values */
            printf("other type: %s", lua_typename(L, i));
            break;
        }

        printf("\n");   /** put a separator */
    }

    printf("} --end dump\n");   /** end the listing */

    return;
}

#if (TESTING)
int
main(int argc, char *argv[])
{
    lua_State *L = luaL_newstate(); /* opens Lua */

    lua_pushboolean(L, 1);
    lua_pushnumber(L, 110);
    lua_pushnil(L);
    lua_pushstring(L, "Hell word, I am luaer.");

    stack_dump(L);

    /**
     * Segmentation fault
    lua_pushvalue(L, -68);
    stack_dump(L);
    */

    lua_replace(L, 3);
    stack_dump(L);

    lua_settop(L, 6);
    stack_dump(L);

    lua_remove(L, -3);
    stack_dump(L);

    lua_settop(L, -5);
    stack_dump(L);

    lua_close(L);

    return 0;
}
#endif
