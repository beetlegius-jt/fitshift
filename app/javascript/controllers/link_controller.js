import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="link"
export default class extends Controller {
  static values = {
    active: true
  }

  open(event) {
    if (!this.activeValue) event.preventDefault()
  }
}
