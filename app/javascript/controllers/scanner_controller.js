import { Controller } from "@hotwired/stimulus"
import jsQR from 'jsqr'

// Connects to data-controller="scanner"
export default class extends Controller {
  static targets = ["canvas", "output", "form"]

  connect() {
    if (document.documentElement.hasAttribute('data-turbo-preview')) return

    this.video = document.createElement("video")
    this.canvas = this.canvasTarget.getContext('2d', { willReadFrequently: true })

    navigator
      .mediaDevices
      .getUserMedia({ video: { facingMode: "environment" } })
      .then((stream) => {
        this.stream = stream
        this.video.srcObject = stream
        this.video.play()
      })

    setInterval(() => this.tick(), 50)
  }

  disconnect() {
    if (this.stream != undefined) {
      this.stream.getTracks().forEach((track) => track.stop())
    }
  }

  tick() {
    if (!this.ready()) return

    this.canvas.drawImage(this.video, 0, 0, this.canvasTarget.width, this.canvasTarget.height)
    let imageData = this.canvas.getImageData(0, 0, this.canvasTarget.width, this.canvasTarget.height)
    let code = jsQR(imageData.data, imageData.width, imageData.height, {
      inversionAttempts: 'dontInvert'
    })

    if (code?.data) {
      this.disconnect()

      this.canvasTarget.hidden = true
      this.outputTarget.value = code.data
      this.formTarget.submit()
    }
  }

  ready() {
    return (this.stream?.active && this.video.readyState === this.video.HAVE_ENOUGH_DATA)
  }
}
