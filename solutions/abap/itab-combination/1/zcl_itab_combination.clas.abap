CLASS zcl_itab_combination DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF alphatab_type,
             cola TYPE string,
             colb TYPE string,
             colc TYPE string,
           END OF alphatab_type.
    TYPES alphas TYPE STANDARD TABLE OF alphatab_type.

    TYPES: BEGIN OF numtab_type,
             col1 TYPE string,
             col2 TYPE string,
             col3 TYPE string,
           END OF numtab_type.
    TYPES nums TYPE STANDARD TABLE OF numtab_type.

    TYPES: BEGIN OF combined_data_type,
             colx TYPE string,
             coly TYPE string,
             colz TYPE string,
           END OF combined_data_type.
    TYPES combined_data TYPE STANDARD TABLE OF combined_data_type WITH EMPTY KEY.

    METHODS perform_combination
      IMPORTING
        alphas             TYPE alphas
        nums               TYPE nums
      RETURNING
        VALUE(combined_data) TYPE combined_data.

  PROTECTED SECTION.
  PRIVATE SECTION.


ENDCLASS.

CLASS zcl_itab_combination IMPLEMENTATION.

  METHOD perform_combination.
    DATA(lt_result) = VALUE combined_data( ).
    LOOP AT alphas INTO DATA(ls_alpha).
    DATA(lv_index) = sy-tabix.
    READ TABLE nums INDEX lv_index INTO DATA(ls_num).
  
    APPEND VALUE #( colx = ls_alpha-cola && ls_num-col1
                  coly = ls_alpha-colb && ls_num-col2
                  colz = ls_alpha-colc && ls_num-col3) TO lt_result.
    ENDLOOP.     
    combined_data = lt_result.
  ENDMETHOD.

ENDCLASS.
