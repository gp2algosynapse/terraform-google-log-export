/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


module "log_export" {
  source               = "terraform-google-modules/log-export/google"
  destination_uri      = module.destination.destination_uri
  log_sink_name        = "test-splunk-sink"
  parent_resource_id   = var.parent_resource_id
  parent_resource_type = "project"
}

module "destination" {
  source                   = "terraform-google-modules/log-export/google//modules/pubsub"
  project_id               = var.project_id
  topic_name               = "splunk-sink"
  log_sink_writer_identity = module.log_export.writer_identity
  create_subscriber        = true
}

