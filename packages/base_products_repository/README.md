# Base Products Repository
## Structure 
```
- data
  - open_food_facts_api_client (concrete) -> base_products_api_client
  - base_product_model (extends) -> base_product_entity
  - base_products_repository_impl (concrete) -> base_products_repository
    Uses the _base_products_api_client_ to perform operations.

- domain
  - base_products_api_client (abstract)
  - base_products_repository (abstract)
  - base_product_entity

```
