# KittenCannon™ Challenge

KittenCannon™ is a proprietary, state-of-the-art system for selling and shipping
cats to cat enthusiasts worldwide.

Your challenge, should you choose to accept it:

1. Basic cat breed tagging API

Basic System

```
Entity (cat breed):
  |
  -- Tags (traits)
```

##### Concrete Example

```
American Bobtail
  |
  -- affectionate
  -- low shedding
  -- playful
  -- intelligent

Cymric
  |
  -- affectionate
  -- has no tail
  -- friendly

Norwegian Forest Cat
  |
  -- low shedding
  -- pet friendly
  -- knows kung fu
  -- climbs trees
```

## The dbz approach

Because this is an open ended exercise, I'd like to take the opportunity to learn something new: **graphql**
This will definitely make the challenge take much longer than it should, but I will get first hand experience to determine how graphql works as a solution to JSON apis.

### Graphql implementation details

I have implemented the following methods:

```
allBreeds
allTags

createBreed(name: String)
createTag(name: String, breed_id: ID)

updateBreed(name: String, id: ID)
updateTag(name: String, id: ID)

deleteBreed(name: String, id: ID)
deleteTag(id: ID)
```

The following fields are accessable from the Breed and Tag type:

1. id
1. name
1. tags / breeds
1. tag_count / breed_count

Here is an example query to view all of the breeds with their name and tags. Each tag will also contain the name and id.

```
query {
  allBreeds {
    name
    id
    tags {
      name
      id
    }
  }
}
```

It would return something that looks like this:
```
{
  "data": {
    "allBreeds": [
      {
        "name": "turkish van",
        "id": "4",
        "tags": [
          {
            "name": "soft",
            "id": "5"
          },
          {
            "name": "odd eyed (different color eyes)",
            "id": "6"
          },
          {
            "name": "swims",
            "id": "7"
          }
        ]
      },
      {
        "name": "ragdoll",
        "id": "5",
        "tags": [
          {
            "name": "soft",
            "id": "5"
          },
          {
            "name": "lazy",
            "id": "8"
          }
        ]
      }
    ]
  }
}
```

 - [Code Example: QueryType](/app/graphql/types/query_type.rb)
 - [Code Example: BreedType](/app/graphql/types/breed_type.rb)
 - [Code Example: CreateTag Resolver](/app/graphql/resolvers/create_tag.rb)

#### Exception Handling

I found a neat gem called [graphql-errors](https://github.com/exAspArk/graphql-errors) which allowed me to put all of my exception handling for errors into my schema.
Now JSON gives nice pretty errors.

Example mutation:

```
mutation {
  deleteTag(id: 200) {
    id
  }
}
```

Will return the following JSON if `id = 200` can not be found:

```
{
  "data": {
    "deleteTag": null
  },
  "errors": [
    {
      "message": "Record not found: Couldn't find Tag with 'id'=200",
      "locations": [
        {
          "line": 46,
          "column": 3
        }
      ],
      "path": [
        "deleteTag"
      ]
    }
  ]
}
```

 - [Code Example: Exception handling on the graphql schema](/app/graphql/catapault_schema.rb)

### Rails backend

There are two main models: `Breed` and `Tag`.
I originally wanted to experiment with the `has_and_belongs_to_many` association rather than the more conventional `has_many :through` association because it's fun to try new things (*cough* graphql *cough*).
HABTM does not have a join model, and when adding tags through the breeds' `tags` association, I can not perform model level validations and have to rely on db level constraints.
I'm expecting tons and tons of people to use my service, so I'd like to spare the db from doing all of my validations for me, so I switched to a `has_many :through` association with a validation on the `BreedTag` model.
We still need the db level constraints in case there are concurrent updates to a breed's `tags`.

 - [Code Example: BreedTags join table migration](/db/migrate/20171104171821_create_breed_tags.rb)
 - [Code Example: Breed model](/app/models/breed.rb)

#### Orphaned tags

The Humane Tag Association™ monitored the creation of the tag deletion api.
No tags are orphaned (even for a second) during the deletion of a breed.

 - [Code Example: See SQL skillz translated into ActiveRecord](/app/models/breed.rb#L17-L19)

### Testing

I am a big fan of RSpec, Shoulda-Matchers, Capybara, FactoryGirl, Fuubar, and Database-Cleaner for helping me test.
I found a helpful gem called [rspec-graphql_matchers](https://github.com/khamusa/rspec-graphql_matchers) which provided a little bit of syntactic sugar when testing my graphql api.

I followed bits of advice from [graphql-ruby.org](http://graphql-ruby.org/schema/testing.html), [how to graphql](https://github.com/howtographql/howtographql/blob/8614026b99e38dbf0a73aaecefd1f703efbedddf/content/backend/graphql-ruby/3-mutations.md#testing-with-unit-test), and [rspec-graphql_matcher](https://github.com/khamusa/rspec-graphql_matchers) on proper ways to test the graphql API.
However, there is not a lot of documentation and guides on this in the wild, and a good blog post would do the rails community a great service.

 - [Code Example: Breed model spec](/spec/models/breed_spec.rb)
 - [Code Example: BreedType spec](/spec/graphql/types/breed_type_spec.rb)
 - [Code Example: CreateBreed resolver spec](/spec/graphql/resolvers/create_breed_spec.rb)

