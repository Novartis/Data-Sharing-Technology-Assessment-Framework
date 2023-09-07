# Copyright 2023 Novartis Institutes for BioMedical Research Inc.
# 
# Licensed under the MIT License (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# https://www.mit.edu/~amini/LICENSE.md
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file

pkgload::load_all(export_all = FALSE,helpers = FALSE,attach_testthat = FALSE)
options( "golem.app.prod" = TRUE)
run_app(
  options = list(port = 3838, host = "0.0.0.0") # for docker
) # add parameters here (if any)
