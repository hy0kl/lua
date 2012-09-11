#include "ext.h"
/**
 * gcc color_table.c -llua -lm -ldl
 * */

#define MAX_COLOR 255
#define FILE_NAME_LEN   128
#define JSON_BUF_LEN    1024 * 8
#define MAX_FILE_NAME   512

typedef struct _color_table_t
{
    char *name;
    u_int32_t red, green, blue;
}color_table_t;

typedef struct _config_t
{
    int  log_level;
    int  log_size;
    char prefix[MAX_FILE_NAME];
    char log_name[MAX_FILE_NAME];
} config_t;

int get_field(lua_State *L, const char *key, void *dest, const size_t size)
{
    assert(NULL != dest);
    assert(size > 0);

    int result = -1;

    int  t;
    int  number = 0;
    char tmp_str[MAX_FILE_NAME];

    lua_pushstring(L, key);
    lua_gettable(L, -2);

    t = lua_type(L, -1);
    switch (t)
    {
    case LUA_TSTRING:   /** strings */
        snprintf(tmp_str, sizeof(tmp_str), "%s", lua_tostring(L, -1));
        memmove(dest, tmp_str, size);
        break;

    case LUA_TBOOLEAN:  /** booleans */
        printf("bool: %s\n", lua_toboolean(L, -1) ? "true" : "false");
        break;

    case LUA_TNUMBER:   /** numbers */
        number = (int)lua_tonumber(L, -1);
        memmove(dest, &number, size);
        break;

    default:    /** other values */
        ext_error(L);
        goto FINISH;
    }

    lua_pop(L, 1);
    result = 0;

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

// global config
config_t gconfig;

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

    lua_getglobal(L, "gconfig");
    if (! lua_istable(L, -1))
    {
        fprintf(stderr, "gconfig is NOT table.\n");
        goto FINISH;
    }
    if (0 != get_field(L, "prefix", gconfig.prefix, sizeof(gconfig.prefix)))
    {
        fprintf(stderr, "get gconfig.prefix fail.\n");
        goto FINISH;
    }
    if (0 != get_field(L, "log_name", gconfig.log_name, sizeof(gconfig.log_name)))
    {
        fprintf(stderr, "get gconfig.log_name fail.\n");
        goto FINISH;
    }
    if (0 != get_field(L, "log_level", &gconfig.log_level, sizeof(gconfig.log_level)))
    {
        fprintf(stderr, "get gconfig.log_level fail.\n");
        goto FINISH;
    }
    if (0 != get_field(L, "log_size", &gconfig.log_size, sizeof(gconfig.log_size)))
    {
        fprintf(stderr, "get gconfig.log_size fail.\n");
        goto FINISH;
    }

    printf("gconfig.prefix   = %s\n", gconfig.prefix);
    printf("gconfig.log_name = %s\n", gconfig.log_name);
    printf("gconfig.log_level= %d\n", gconfig.log_level);
    printf("gconfig.log_size = %d\n", gconfig.log_size);

FINISH:
    lua_close(L);

    return 0;
}
