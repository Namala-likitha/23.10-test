 include: "//snowflake_test_s/views/orders.view.lkml"

view: orderse {
  # sql_table_name: "LOOKER_TEST"."ORDERS" ;;
  extends: [orders]
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }


  filter: date_filter {

    type: date
    sql: ${created_raw} < COALESCE({% date_end date_filter %}, now())
      AND (${created_raw} >= {% date_start date_filter %} OR ${created_raw} is NULL OR {% date_start date_filter %} IS NULL)
      ;;
  }

  dimension: reporting_period_start_date {
    type: date
    sql: {% date_start date_filter %} ;;
  }


  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year,day_of_week_index,day_of_week]
    sql: ${TABLE}."CREATED_AT" ;;
  }
  dimension: order_amount {
    type: number
    sql: ${TABLE}."ORDER_AMOUNT" ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }
  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.id,
  users.name,
  billion_orders.count,
  hundred_million_orders.count,
  order_items.count
  ]
  }

}
