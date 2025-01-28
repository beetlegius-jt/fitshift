// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import Timeago from "@stimulus-components/timeago"
eagerLoadControllersFrom("controllers", application)

application.register("timeago", Timeago)
