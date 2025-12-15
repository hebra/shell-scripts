Conduct a comprehensive analysis of the current repository to understand its architecture, user flows, and data flows. Follow the systematic analysis framework from .clinerules/generic/analysis.xml to ensure thorough investigation and high-confidence understanding.

Your analysis must include:

1. Repository Structure Analysis
   - Map the overall project architecture and organization
   - Identify key directories, modules, and their purposes
   - Document technology stack and frameworks used
   - Analyze configuration files and dependencies

2. User Flow Analysis
   - Identify all user-facing entry points (web interfaces, APIs, CLI tools)
   - Map complete user journeys from entry to completion
   - Document user roles and permissions
   - Identify authentication and authorization flows

3. Data Flow Analysis
   - Map data sources, transformations, and destinations
   - Identify database schemas and relationships
   - Document API endpoints and data contracts
   - Trace data flow through system components

4. System Integration Analysis
   - Identify external service dependencies
   - Map message queues, event streams, and pub/sub patterns
   - Document integration points and data exchange formats
   - Analyze error handling and retry mechanisms

5. Visual Documentation Creation
   - Generate mermaid flowcharts for user flows
   - Create mermaid diagrams for data flows
   - Produce sequence diagrams for key system interactions
   - Include architecture overview diagrams

Apply the confidence assessment framework from .clinerules/generic/analysis.xml throughout your analysis. Rate your understanding on a 0-10 scale for each major component analyzed.

Before proceeding with any analysis conclusions, assess your confidence level using the framework from .clinerules/generic/analysis.xml:

Confidence Assessment Template:

Component: [Specific area being analyzed]
Current Confidence: [X]/10

Understanding Status:
✓ Business rules: [Complete/Partial/Unknown]
✓ Technical architecture: [Complete/Partial/Unknown]
✓ Integration effects: [Complete/Partial/Unknown]
✓ Data flow patterns: [Complete/Partial/Unknown]
✓ User interaction patterns: [Complete/Partial/Unknown]

Knowledge Gaps:
- [Specific gap 1]
- [Specific gap 2]

Clarification Requirements:
If your confidence level is 8/10 or below for any major component, you must ask specific clarifying questions before proceeding with that analysis section. Focus your questions on the identified knowledge gaps.

Use the investigation checklists from analysis.xml:
- Business Logic Investigation for user workflow analysis
- Database Investigation for data flow analysis
- API Investigation for integration analysis
- Integration Investigation for external dependencies
- Infrastructure Investigation for system architecture

Create a single comprehensive markdown file saved to `.cline_docs/repository-analysis.md` (create the .cline_docs folder if it doesn't exist).

The output file must contain:

1. Executive Summary
   - High-level architecture overview
   - Key technologies and frameworks identified
   - Major user flows and data flows summary

2. Architecture Analysis
   - System components and their relationships
   - Technology stack breakdown
   - Configuration and deployment patterns

3. User Flow Documentation
   - Complete user journey maps
   - Authentication and authorization flows
   - User role and permission analysis
   - Mermaid flowcharts for each major user flow

4. Data Flow Documentation
   - Data sources and destinations
   - Transformation and processing patterns
   - Database relationships and schemas
   - Mermaid diagrams for data flow patterns

5. Integration Analysis
   - External service dependencies
   - API contracts and data formats
   - Event-driven architecture patterns
   - Sequence diagrams for key integrations

6. Confidence Assessment Summary
   - Confidence ratings for each analyzed component
   - Identified knowledge gaps and assumptions
   - Areas requiring further investigation

Include all mermaid diagrams and sequence diagrams directly in the markdown file using proper code blocks with mermaid syntax.

Upon completion of .cline_docs/repository-analysis.md, offer the user the option to create a persistent knowledge base:

"Based on this comprehensive repository analysis, I can now create a .memory-bank folder structure that will serve as a persistent knowledge base for future development work. This memory bank will contain:
- Distilled architectural insights and patterns identified in this analysis
- Key business rules and technical constraints discovered
- Reusable code patterns and best practices found in the codebase
- Integration points and dependencies mapped during analysis

Would you like me to generate the .memory-bank folder contents using the insights from this analysis? This will create a structured knowledge base following the guidelines in .clinerules/generic/memory-bank.md that can accelerate future development tasks."

If the user agrees, start a new task to create the memory-bank structure using the analysis insights from .cline_docs/repository-analysis.md as source material.