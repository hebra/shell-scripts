<TASK>
Analyse this project, and create or update the documentation.
</TASK>

<GIT>
- Include the Git history in your analysis.
- When using a git command that supports the --no-pager parameter use that paramater to prevent the user having to manually exit the pager.
- Do NOT automatically commit to Git after the documentation was updated.
</GIT>

<IMPORTANT>
DO NOT MAKE ANY CODE OR CONFIGURATION CHANGES.

DO NOT MAKE ASSUMPTIONS: IF THERE IS NOT ENOUGH DATA AVAILABLE DO NOT CHANGE OR ADD DOCUMENTATION PURELY ON GUESSWORK. In these cases create a document QUESTIONS.md to summarize these knowledge gaps.

DO NOT MAKE ASSUMPTIONS PURELY ON THE PROJECTS NAME: IF IN DOUBT DO NOT CHANGE OR ADD DOCUMENTATION.

ASSUME ALL FILE CHANGES WILL BE APPROVED. DO NOT ASK TO REVIEW CHANGES, JUST UPDATE FILES IMMEDIATELY.
</IMPORTANT>

<DIAGRAMS>
If you want to create or update charts and diagrams, use Mermaid in its latest version for these.
Do not use ASCII art, or PlantUML for diagrams and charts, use Mermaid instead.
If there are existing charts and diagrams using ASCII art, PlantUML or similar transform them into Mermaid diagrams.

Use version 11 of Mermaid.
</DIAGRAMS>

<DOCUMENTS>
- Create or update the README.md to document an overview of the project, its purpose and requirements to run.
- Unless the project is pure documentation or configuration, create or update the ARCHITECTURE.md to cover the solution design and architecture of this project based in the current code implementation, API specifications and configurations.
- Unless the project is pure documentation or configuration, create or udpate the DEVELOPMENT.md to include details on how to locally setup, start and develop the project. Include precodnitions for local development. Include instructions on how to test the project.
- Unless the project is pure documentation or configuration, create or update the DEPLOYMENT.md to cover an overview on how to deploy the project, take any existing GitHub Actions workflows, or Terraform files into account.
- link to the development, deployment and architecture documents from the main README.md file.
Once everything is updated create a git commit for the changes.
</DOCUMENTS>
