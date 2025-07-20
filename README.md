# Kleya

Kleya is a simple (with a vision) capture tool for Ruby apps. It uses Ferrum as a headless browser to capture screenshots of URLs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kleya'
```

And then,

```bash
bundle install
```

Or install it yourself as:

```bash
gem install kleya
```

## Basic Example

The simplest way to capture a screenshot and save it can look like this,

```ruby
Kleya.capture('https://www.hellotext.com').save
```

## Usage

```ruby
require 'kleya'

# Create a browser instance and capture a screenshot
browser = Kleya::Browser.new
artifact = browser.capture('https://example.com')

# Save to file with auto-generated filename
artifact.save  # => "screenshot_20240112_143022.jpg"

# Access the data
puts artifact.base64    # Base64-encoded image data
puts artifact.binary # Binary-eencoded image data
puts artifact.size      # File size in bytes
puts artifact.content_type  # "image/jpeg"

# Clean up
browser.quit
```

### Presets

Kleya includes convenient viewport presets for social media platforms and common devices. You can pass any of the following values when initializing a browser instance.

- `desktop`: default (1920x1080)

- `x` (1200x675)
- `facebook` (1200x630)
- `instagram` (1080x1080)
- `linkedin` (1200x627)

- `laptop` (1366x768)
- `tablet` (768x1024)
- `mobile` (375x667)

```ruby
# Social media optimized screenshots
browser = Kleya::Browser.new(preset: :facebook)

artifact = browser.capture('https://mysite.com/blog/post-1')
artifact.save('social-media/')  # Saves as social-media/screenshot_20240112_143022.jpg
```

### Custom Viewport Sizes

If none of the builtin presets work for your taste, simply pass `width` and `height` of the dimensions of the browser tab.

```ruby
browser = Kleya::Browser.new(width: 1600, height: 900)
```

### Browser

Kleya is built on-top of [Ferrum](https://github.com/rubycdp/ferrum) and thus, accepts all the [Customization options supported by Ferrum](https://github.com/rubycdp/ferrum?tab=readme-ov-file#customization).

```ruby
browser = Kleya::Browser.new
```

A Kleya instance uses a single persistent Ferrum connection underneath. This means a less resource-intensive script when running a batch of screenshots in the same session, once you're ready to quit the active browser session. You can do the following.

```ruby
browser.quit
```

This wil quite the Ferrum connection and close it. When calling `capture` again on the same instance, a new Ferrum connection is established and kept alive until explicitly quit.

Kelay offers a top-level capture method as well which takes a screenshot and quits the browser connection after capturing.

```ruby
Kleya.capture('https://www.hellotext.com')
```

### Capture options

Alongisde the options you pass for the instance, there's some extra configurable settings you can tweak to your usecase.

- `format`: species the format of the image captures, i.e `jpeg` or `png`.
- `encoding`: species the encoding of the image, possible options is `binary` or `base64` (defeault). Regardless, the `Kleya::Artifact` object responds to `#binary` and `base64` when needed.
- `quality`: an integer between 1 - 100 that determines the quality of the final image, higher quality images result in bigger sizes and may not work correctly in some situations such as the Open Graph protocl, you can tweak and test this. Defaults to `90`.

```ruby
artifact = browser.capture('https://example.com', format: :jpeg, quality: 85, encoding: :base64)

artifact.binary # The binary-encoded image
artifact.base64 # The base-64 representation of the image.
```

Learn more about Artifacts in the next section.

### Working with Artifacts

The `capture` method returns an `Artifact` object with useful methods:

```ruby
artifact = browser.capture('https://example.com')

# File operations
artifact.save                                       # Save with auto-generated filename
artifact.save('screenshots/')                       # Save to directory with auto-generated filename
artifact.save('custom-name.jpg')                    # Save with specific filename
artifact.filename                                   # => "screenshot_20240112_143022.jpg"
artifact.filename(prefix: 'homepage')               # => "homepage_20240112_143022.jpg"

# Data access
artifact.base64                                     # Base64-encoded string
artifact.binary                                     # Raw binary data
artifact.size                                       # Size in bytes

# Metadata
artifact.content_type                               # => "image/jpeg"
artifact.dimensions                                 # => { width: 1920, height: 1080 }
```

###

```ruby
# Configure browser behavior
browser = Kleya::Browser.new(
  headless: false,              # Show browser window (default: true)
  timeout: 30,                  # Navigation timeout in seconds (default: 60)
  process_timeout: 120          # Process timeout in seconds (default: 60)
)

# The browser is automatically started on first use
# You can explicitly clean up when done
browser.quit
```

## Error Handling

Kleya provides specific error types for common issues:

```ruby
begin
  artifact = browser.capture('https://example.com')
rescue Kleya::TimeoutError => e
  puts "Page took too long to load: #{e.message}"
end
```

## Requirements

- Ruby 3.3.0 or higher
- Chrome/Chromium browser installed on your system

## Roadmap

### v0.2.0 - Enhanced Capture Control

- [ ] Wait strategies (`wait_for: '.element'`, `wait_until: :network_idle`)
- [ ] Full page screenshots (not just viewport)
- [ ] Built-in retry mechanism with configurable delays

### v0.3.0 - Performance & Reliability

- [ ] Memory usage optimization for large batches
- [ ] Request blocking (ads, analytics, fonts)
- [ ] Custom user agents for mobile rendering

### v0.4.0 - Developer Experience

- [ ] CLI tool for quick captures (`kleya capture https://example.com`)
- [ ] Debug mode with browser preview
- [ ] Capture metrics (timing, size, errors)

### Future Considerations

- **Rails Engine**: Dedicated Rails integration with routes, Active Storage helpers, and background job support
- **Comparison tools**: Diff detection between captures
- **PDF generation**: Export captures as PDFs

### Non-Goals

- Video recording
- Browser automation beyond screenshots
- Image manipulation/editing

We're keeping Kleya focused on doing one thing excellently: capturing web page screenshots with a simple, reliable API.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hellotext/kleya. This project is intended to be a safe, welcoming space for collaboration.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
