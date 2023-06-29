view: hundred_million_orders {
  sql_table_name: "LOOKER_TEST"."HUNDRED_MILLION_ORDERS" ;;

  dimension: customer_id {
    type: string
    sql: ${TABLE}."CUSTOMER_ID" ;;
  }
  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."ORDER_ID" ;;
  }
  dimension: order_price {
    type: number
    sql: ${TABLE}."ORDER_PRICE" ;;
  }
  measure: count {
    type: count
    drill_fields: [orders.id]
  }
}
