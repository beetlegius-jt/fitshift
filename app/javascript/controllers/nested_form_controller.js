import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {
  static targets = ["container", "template"]

  add(_event) {
    const content = this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, new Date().valueOf())

    this.containerTarget.insertAdjacentHTML('beforeend', content)
  }

  remove(event) {
    event.target.closest(".nested-fields").remove()
  }
}
