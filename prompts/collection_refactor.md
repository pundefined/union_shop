# Refactoring Collections Page - LLM Prompt

You are refactoring a Flutter e-commerce app's collections feature. Complete the following tasks:

## Task 1: Extract CollectionTile to Separate File
- Create a new file at `lib/widgets/collection_tile.dart`
- Move the `CollectionTile` widget class from `lib/screens/collections_page.dart` to this new file
- Ensure all necessary imports are included in the new file
- Update `lib/screens/collections_page.dart` to import and use the `CollectionTile` from the new file
- The `CollectionTile` should remain fully functional with no changes to its behavior

## Task 2: Update Collection Model Usage
- The local `Collection` class currently defined in `collections_page.dart` should be replaced with the `Collection` model from `lib/models/collection.dart`
- Update all references in `collections_page.dart` and `collection_tile.dart` to use the imported model
- Ensure the data structure matches: the model should have `title` and `imageUrl` properties (adjust the model if needed)
- Update the `sampleCollections` list to work with the imported `Collection` model

## Task 3: Implement Navigation to Collection Page
- When a user taps on a `CollectionTile`, instead of showing a SnackBar, navigate to the collection details page
- Use `Navigator.pushNamed()` with the route name `'/collection'` (or an existing collection page route if one exists)
- Pass the tapped `Collection` object as an argument to the destination page
- The user should see the dedicated collection page displaying products from that specific collection

## Expected Behavior
- Collections display in a responsive grid as before
- Each collection tile shows an image with overlay text
- Tapping a tile smoothly navigates to a dedicated page showing that collection's products
- The app maintains its current visual design and responsive layout