# Homepage Banner Carousel Feature

## Overview
Convert the static main banner image on the homepage into an interactive carousel that displays multiple slides with images, text, and subtext.

## Visual Components
- **Carousel Container**: Full-width banner area displaying one slide at a time
- **Slide Content**: Each slide contains:
  - Background image or image element
  - Primary text/heading
  - Secondary text/subtext
- **Navigation Buttons**: 
  - "Previous" button (left arrow) on the left side
  - "Next" button (right arrow) on the right side
- **Indicator Dots**: Row of dots below the carousel, one for each slide

## User Interactions

### Forward Button
- **Action**: User clicks the "Next" button or right arrow
- **Result**: Carousel advances to the next slide with a smooth transition
- **Behavior at End**: When on the last slide, clicking next loops back to the first slide

### Back Button
- **Action**: User clicks the "Previous" button or left arrow
- **Result**: Carousel moves to the previous slide with a smooth transition
- **Behavior at Start**: When on the first slide, clicking back loops to the last slide

### Indicator Dots
- **Display**: Dots are inactive (lighter styling) for non-active slides
- **Active State**: The dot corresponding to the current slide is highlighted/active
- **Action**: User clicks any dot to jump directly to that slide
- **Result**: Carousel transitions to the selected slide

## Auto-Play (Optional)
- Carousel automatically advances to the next slide every 5 seconds
- Auto-play pauses when the user hovers over the carousel
- Auto-play resumes when the user moves the mouse away

## Accessibility
- Buttons and dots have appropriate ARIA labels
- Carousel is keyboard navigable (arrow keys)
- Sufficient color contrast for all interactive elements