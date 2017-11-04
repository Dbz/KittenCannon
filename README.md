# Catapult™ Challenge

Catapult™ is a proprietary, state-of-the-art system for selling and shipping
cats to cat enthusiasts worldwide.

This coding challenge consists of three options based on different levels of
experience and time constraints.  Feel free to undergo any of the following
challenges, and if you feel you have enough time, you're more than welcome to
complete more than one.

Your challenges, should you choose to accept them:

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
deleteTag(name: String, id: ID)
```

Here is an example query to view all of the breeds with thier name and tags. Each tag will also contain the name and id.

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

