
version: 2
models:
  - name: dim_customers
    description: 'dimension table for customers'
    columns:
      - name: customer_id
        description: 'the primary key for the table'
        tests:
          -  unique
          - not_null
          - relationship
