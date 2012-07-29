#include "ext.h"
/**
 * gcc color_table.c -llua -lm -ldl
 * */

#define MAX_COLOR 255
#define FILE_NAME_LEN   128
#define JSON_BUF_LEN    1024 * 8

typedef struct _color_table_t
{
    char *name;
    u_int32_t red, green, blue;
}color_table_t;

u_int32_t get_field(lua_State *L, const char *key)
{
    u_int32_t result = 0;
    
    lua_pushstring(L, key);
    lua_gettable(L, -2);    /** get backgroud[key] */
    if (! lua_isnumber(L, -1))
    {
        ext_error(L);
        goto FINISH;
    }

    result = (u_int32_t)lua_tonumber(L, -1) * MAX_COLOR;
    lua_pop(L, 1);

FINISH:
    return result;
}

void set_field(lua_State *L, const char *key, u_int32_t value)
{
    lua_pushstring(L, key);
    lua_pushnumber(L, (double)value / MAX_COLOR);
    lua_settable(L, -3);

    return;
}

void set_color(lua_State *L, color_table_t *ct)
{
    lua_newtable(L);
    
    set_field(L, "red",   ct->red);
    set_field(L, "green", ct->green);
    set_field(L, "blue",  ct->blue);

    lua_setglobal(L, ct->name);

    return;
}

int
main(int argc, char *argv[])
{
    int i = 0;
    char file_name[FILE_NAME_LEN] = "./color_config.lua";
    char json_buf[JSON_BUF_LEN]   = {0};

    lua_State *L = luaL_newstate(); /* opens Lua */
    luaL_openlibs(L);   /** Opens all standard Lua libraries into the given state. */

    color_table_t color_table[] = {
        {"WHITE", MAX_COLOR, MAX_COLOR, MAX_COLOR},
        {"RED",   MAX_COLOR, 0,         0},
        {"GREEN", 0,         MAX_COLOR, 0},
        {"BLUE",  0,         0,         MAX_COLOR},
        {"BLACK", 0,         0,         0},
        {NULL,    0,         0,         0}
    };

    while (color_table[i].name)
    {
        set_color(L, &(color_table[i]));
        i++;
    }

    /**int lua_pcall (lua_State *L, int nargs, int nresults, int msgh);*/
    if (luaL_loadfile(L, file_name) || lua_pcall(L, 0, 1, 0))
    {
        ext_error(L); 
        goto FINISH;
    }

    lua_getglobal(L, "backgroud");
    if (! lua_isstring(L, -1))
    {
        ext_error(L);
        goto FINISH;
    }

    snprintf(json_buf, JSON_BUF_LEN, "%s", lua_tostring(L, -1));

    fprintf(stderr, "The JSON is: [%s]\n", json_buf);

FINISH:
    lua_close(L);

    return 0;
}
