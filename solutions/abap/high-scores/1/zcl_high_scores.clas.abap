CLASS zcl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.


CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD list_scores.
    result = scores_list.
  ENDMETHOD.

  METHOD latest.
    IF lines( scores_list ) > 0.
      READ TABLE scores_list INTO result INDEX lines( scores_list ).
    ENDIF.
  ENDMETHOD.

  METHOD personalbest.
    IF lines( scores_list ) > 0.
      SORT scores_list DESCENDING.
      READ TABLE scores_list INTO result INDEX  1.
    ENDIF.
  ENDMETHOD.

  METHOD personaltopthree.
    DATA: lt_sorted TYPE integertab,
          lv_score TYPE i.

    IF lines( scores_list ) = 0.
      RETURN.
    ENDIF.

    lt_sorted = scores_list.
    SORT lt_sorted DESCENDING.

    LOOP AT lt_sorted INTO lv_score FROM 1 TO 3.

      APPEND lv_score TO result.
    ENDLOOP.
  ENDMETHOD.


ENDCLASS.
