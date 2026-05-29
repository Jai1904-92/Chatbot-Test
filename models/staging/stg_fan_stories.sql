{{ config(materialized='view') }}

with source as (

    select * from {{ source('raw', 'fan_stories') }}

),

cleaned as (

    select
        id,
        trim(name) as fan_name,
        fan_id,
        fan_since as year_became_fan,
        extract(year from current_date) - fan_since as years_as_fan,
        split_part(location, ',', 1) as city,
        trim(split_part(location, ',', 2)) as state,
        fav_player,
        first_match,
        body as story
    from source

)

select * from cleaned