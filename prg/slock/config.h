/*
 * ~/prg/slock/config.h
 * vi:ft=c
 */

/* user and group to drop privileges to */
static const char *user  = "ty";
static const char *group = "ty";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#1b180d",     /* after initialization */
	[INPUT] =  "#363019",   /* during input */
	[FAILED] = "#CCA86B",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
