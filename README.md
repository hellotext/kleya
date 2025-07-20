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

## Usage

### Basic Example

```ruby
require 'kleya'

# Create a browser instance and capture a screenshot
browser = Kleya::Browser.new
artifact = browser.capture('https://example.com')

# Save to file with auto-generated filename
artifact.save  # => "screenshot_20240112_143022.jpg"

# Access the data
puts artifact.base64    # Base64-encoded image data
puts artifact.binay # Binary-eencoded image data
puts artifact.size      # File size in bytes
puts artifact.content_type  # "image/jpeg"

# Clean up
browser.quit
```

### Using Presets

Kleya includes convenient viewport presets for social media platforms and common devices:

```ruby
# Social media optimized screenshots
browser = Kleya::Browser.new(
  width: Kleya::Preset::TWITTER.width,
  height: Kleya::Preset::TWITTER.height
)
artifact = browser.capture('https://mysite.com/blog/post-1')
artifact.save('social-media/')  # Saves as social-media/screenshot_20240112_143022.jpg

# Available social media presets:
# - TWITTER (1200x675)
# - FACEBOOK (1200x630)
# - LINKEDIN (1200x627)
# - INSTAGRAM (1080x1080)

# Device presets:
# - DESKTOP (1920x1080)
# - LAPTOP (1366x768)
# - TABLET (768x1024)
# - MOBILE (375x667)
```

### Custom Viewport Sizes

```ruby
# Custom dimensions
browser = Kleya::Browser.new(width: 1600, height: 900)

# Using a custom viewport object
viewport = Kleya::Viewport.new(width: 800, height: 600)
browser = Kleya::Browser.new(width: viewport.width, height: viewport.height)
```

### Screenshot Options

```ruby
browser = Kleya::Browser.new

# PNG format with binary encoding
artifact = browser.capture('https://example.com',
  format: :png,
  encoding: :binary
)

# JPEG with custom quality
artifact = browser.capture('https://example.com',
  format: :jpeg,
  quality: 85,  # 1-100, default is 90
  encoding: :base64
)
```

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

### Advanced Configuration

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
