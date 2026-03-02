CLASS zcl_beer_song DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS recite
      IMPORTING
        !initial_bottles_count TYPE i
        !take_down_count       TYPE i
      RETURNING
        VALUE(result)          TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_beer_song IMPLEMENTATION.

  METHOD recite.
    result = VALUE #( FOR lv_bottles = initial_bottles_count THEN lv_bottles - 1 UNTIL lv_bottles = initial_bottles_count - take_down_count
                      ( |{ COND #( WHEN lv_bottles = 0 THEN |No more| ELSE |{ lv_bottles }| ) } | &&
                        |{ COND #( WHEN lv_bottles = 1 THEN |bottle| ELSE |bottles| ) } of beer on the wall, | &&
                        |{ COND #( WHEN lv_bottles = 0 THEN |no more| ELSE |{ lv_bottles }| ) } | &&
                        |{ COND #( WHEN lv_bottles = 1 THEN |bottle| ELSE |bottles| ) } of beer.| )
                      ( |{ COND #( WHEN lv_bottles <> 0 THEN
                           |Take { COND #( WHEN lv_bottles = 1 THEN |it| ELSE |one| ) } down and pass it around, | &&
                           |{ COND #( WHEN lv_bottles - 1 = 0 THEN |no more| ELSE |{ lv_bottles - 1 }| ) } | &&
                           |{ COND #( WHEN lv_bottles - 1 = 1 THEN |bottle| ELSE |bottles| ) } of beer on the wall.|
                           ELSE |Go to the store and buy some more, 99 bottles of beer on the wall.| ) }| )
                      ( || )
                    ).
    DELETE result INDEX lines( result ).
  ENDMETHOD.

ENDCLASS.