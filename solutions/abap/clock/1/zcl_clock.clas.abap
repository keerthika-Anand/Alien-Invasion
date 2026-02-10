CLASS zcl_clock DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !hours   TYPE i
        !minutes TYPE i DEFAULT 0.
    METHODS get
      RETURNING
        VALUE(result) TYPE string.
    METHODS add
      IMPORTING
        !minutes TYPE i.
    METHODS sub
      IMPORTING
        !minutes TYPE i.

  PRIVATE SECTION.
    
    DATA: current_hours TYPE i,
        current_minutes TYPE i.

ENDCLASS.


CLASS zcl_clock IMPLEMENTATION.

  METHOD add.
    DATA: total_minutes TYPE i.
    total_minutes = current_hours * 60 + current_minutes + minutes.
    total_minutes = total_minutes MOD 1440.
    IF total_minutes < 0.
      total_minutes = total_minutes + 1440.
    ENDIF.
    current_hours = total_minutes DIV 60.
    current_minutes = total_minutes MOD 60.
  ENDMETHOD.

  METHOD constructor.
    DATA: total_minutes TYPE i.
    total_minutes = hours * 60 + minutes.
    total_minutes = total_minutes MOD 1440.
    IF total_minutes < 0.
      total_minutes = total_minutes + 1440.
    ENDIF.
    current_hours = total_minutes DIV 60.
    current_minutes = total_minutes MOD 60.
  ENDMETHOD.

  METHOD get.
    result = |{ current_hours WIDTH = 2 PAD = '0' ALIGN = RIGHT }:{ current_minutes WIDTH = 2 PAD = '0' ALIGN = RIGHT }|.
  ENDMETHOD.

  METHOD sub.
    DATA: total_minutes TYPE i.
    total_minutes = current_minutes - minutes + current_hours * 60.
    total_minutes = total_minutes MOD 1440.
    IF total_minutes < 0.
      total_minutes = total_minutes + 1440.
    ENDIF.
    current_hours = total_minutes DIV 60.
    current_minutes = total_minutes MOD 60.
  ENDMETHOD.

ENDCLASS.
