create or replace package colors
is
    function color(p_text in varchar2, p_fg_color in varchar2 default 'm', p_bg_color in varchar2 default '40m') return varchar2;
    procedure colorize;
    function red(p_text in varchar2) return varchar2;
    function green(p_text in varchar2) return varchar2;
    function blue(p_text in varchar2) return varchar2;
    function yellow(p_text in varchar2) return varchar2;
    function cyan(p_text in varchar2) return varchar2;
    function pink(p_text in varchar2) return varchar2;

    function black_on_white(p_text in varchar2) return varchar2;
    function white_on_red(p_text in varchar2) return varchar2;
    function white_on_green(p_text in varchar2) return varchar2;
    function white_on_pink(p_text in varchar2) return varchar2;
    function bold_black_on_white(p_text in varchar2) return varchar2;
    function bold_white_on_red(p_text in varchar2) return varchar2;
    function bold_white_on_green(p_text in varchar2) return varchar2;
    function bold_white_on_pink(p_text in varchar2) return varchar2;
    function bold_black_on_yellow(p_text in varchar2) return varchar2;
end;
/

create or replace package body colors
is
    -- foreground colors
    COLOR_BLACK  CONSTANT VARCHAR2(5) := '30m';
    COLOR_RED    CONSTANT VARCHAR2(5) := '31m';
    COLOR_GREEN  CONSTANT VARCHAR2(5) := '32m';
    COLOR_YELLOW CONSTANT VARCHAR2(5) := '33m';
    COLOR_BLUE   CONSTANT VARCHAR2(5) := '34m';
    COLOR_PINK   CONSTANT VARCHAR2(5) := '35m';
    COLOR_CYAN   CONSTANT VARCHAR2(5) := '36m';
    COLOR_WHITE  CONSTANT VARCHAR2(5) := '37m';

    -- bold foreground colors
    BOLD_COLOR_BLACK  CONSTANT VARCHAR2(5) := '1;30m';
    BOLD_COLOR_RED    CONSTANT VARCHAR2(5) := '1;31m';
    BOLD_COLOR_GREEN  CONSTANT VARCHAR2(5) := '1;32m';
    BOLD_COLOR_YELLOW CONSTANT VARCHAR2(5) := '1;33m';
    BOLD_COLOR_BLUE   CONSTANT VARCHAR2(5) := '1;34m';
    BOLD_COLOR_PINK   CONSTANT VARCHAR2(5) := '1;35m';
    BOLD_COLOR_CYAN   CONSTANT VARCHAR2(5) := '1;36m';
    BOLD_COLOR_WHITE  CONSTANT VARCHAR2(5) := '1;37m';

    -- background colors
    BG_COLOR_BLACK  CONSTANT VARCHAR2(5) := '40m';
    BG_COLOR_RED    CONSTANT VARCHAR2(5) := '41m';
    BG_COLOR_GREEN  CONSTANT VARCHAR2(5) := '42m';
    BG_COLOR_YELLOW CONSTANT VARCHAR2(5) := '43m';
    BG_COLOR_BLU    CONSTANT VARCHAR2(5) := '44m';
    BG_COLOR_PINK   CONSTANT VARCHAR2(5) := '45m';
    BG_COLOR_CYAN   CONSTANT VARCHAR2(5) := '46m';
    BG_COLOR_WHITE  CONSTANT VARCHAR2(5) := '47m';


    function color(p_text in varchar2, p_fg_color in varchar2 default 'm', p_bg_color in varchar2 default '40m') return varchar2
        is
    begin
        return chr(27)||'['|| p_fg_color ||chr(27)||'['|| p_bg_color || p_text ||chr(27)||'[0m';
        -- chr(27)[ $FG chr(27) [ $BG  p_text  chr(27) [0m
        -- http://www.pixelbeat.org/docs/terminal_colours/
    end color;

    procedure colorize
        is
        vPrintSQL VARCHAR2(32767) := '';
        i pls_integer := 0;
    begin
        dbms_output.enable(100000);
        for fg in (select distinct column_value as fg_color
                   from table(sys.odcivarchar2list ('m', '1m', '30m', '1;30m', '31m', '1;31m', '32m',
                                                    '1;32m', '33m', '1;33m', '34m', '1;34m', '35m', '1;35m',
                                                    '36m', '1;36m', '37m', '1;37m')) order by 1)
            loop
                for bg in (select distinct column_value as bg_color
                           from table(sys.odcivarchar2list ('40m','41m','42m','43m','44m','45m','46m','47m')) order by 1)
                    loop
                        vPrintSQL := vPrintSQL || '['|| chr(27)||'['|| fg.fg_color ||chr(27)||'['|| bg.bg_color ||  LPAD(fg.fg_color ||' + '|| bg.bg_color , 11, '.')||chr(27)||'[0m]';

                        if i = 7 then
                            dbms_output.put_line(vPrintSQL);
                            i := 0;
                            vPrintSQL := '';
                        else
                            i := i + 1;
                        end if;

                    end loop;
            end loop;
    end;

    function red(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, COLOR_RED);
    end red;

    function green(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, COLOR_GREEN);
    end green;

    function blue(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, COLOR_BLUE);
    end blue;

    function yellow(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, COLOR_YELLOW);
    end yellow;

    function pink(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, COLOR_PINK);
    end pink;

    function cyan(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, COLOR_CYAN);
    end cyan;


    function black_on_white(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, COLOR_BLACK, BG_COLOR_WHITE);
    end;

    function white_on_red(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, COLOR_WHITE, BG_COLOR_RED);
    end;

    function white_on_green(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, COLOR_WHITE, BG_COLOR_GREEN);
    end;

    function white_on_pink(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, COLOR_WHITE, BG_COLOR_PINK);
    end;

    function bold_black_on_white(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, BOLD_COLOR_BLACK, BG_COLOR_WHITE);
    end;

    function bold_white_on_red(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, BOLD_COLOR_WHITE, BG_COLOR_RED);
    end;

    function bold_white_on_green(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, BOLD_COLOR_WHITE, BG_COLOR_GREEN);
    end;

    function bold_white_on_pink(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, BOLD_COLOR_WHITE, BG_COLOR_PINK);
    end;

    function bold_black_on_yellow(p_text in varchar2) return varchar2
        is
    begin
        return color(p_text, BOLD_COLOR_BLACK, BG_COLOR_YELLOW);
    end;

end colors;
/