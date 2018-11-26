/*
 * ~/prg/slock/config.h
 * vi:ft=c
 */

/* user and group to drop privileges to */
static const char *user  = "ty";
static const char *group = "ty";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#161111",     /* after initialization */
	[INPUT] =  "#1e180f",   /* during input */
	[FAILED] = "#ccc870",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
