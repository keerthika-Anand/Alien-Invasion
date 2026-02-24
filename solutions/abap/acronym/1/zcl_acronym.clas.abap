CLASS zcl_acronym DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS parse IMPORTING phrase         TYPE string
                  RETURNING VALUE(acronym) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_acronym IMPLEMENTATION.
  METHOD parse.
    DATA: lv_i     TYPE i,
          lv_c     TYPE c LENGTH 1,
          lv_prev  TYPE c LENGTH 1 VALUE '#',
          lv_first TYPE c LENGTH 1 VALUE 'X'.
    
    DO strlen( phrase ) TIMES.
      lv_i = sy-index - 1.
      lv_c = phrase+lv_i(1).
      
      " First letter of each word (after separator or start)
      IF lv_first = 'X' OR lv_prev = ' ' OR lv_prev = '-' OR lv_prev = '_'.
        IF lv_c CO 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.
          lv_c = to_upper( lv_c ).
          CONCATENATE acronym lv_c INTO acronym.
          lv_first = space.
        ENDIF.
      ENDIF.
      
      lv_prev = lv_c.
    ENDDO.
  ENDMETHOD.
ENDCLASS.
