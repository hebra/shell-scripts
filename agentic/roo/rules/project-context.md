<PROJECT_CONTEXT>
  <documentation>
    This file contains project-specific terminology, conventions, and domain knowledge
    that should be applied consistently across all development work.
  </documentation>

  <DOMAIN_TERMINOLOGY>
    <MAPPING>
      <TERM original="dissuing" corrected="issuing">
        <RULE>When extracting a project name from the project repository name and the name contains the term "dissuing" assume that this stands for "issuing".</RULE>
        <CONTEXT>This appears to be a common typo or abbreviation in the codebase that should be interpreted correctly.</CONTEXT>
      </TERM>
    </MAPPING>
  </DOMAIN_TERMINOLOGY>

  <PROJECT_CONVENTIONS>
    <NAMING_CONVENTIONS>
      <RULE>Use consistent terminology across all documentation and code</RULE>
      <RULE>Apply domain mappings when interpreting existing code or documentation</RULE>
      <RULE>Maintain consistency with established project patterns</RULE>
    </NAMING_CONVENTIONS>
  </PROJECT_CONVENTIONS>

  <BUSINESS_CONTEXT>
    <DOMAIN>Media outlet company systems</DOMAIN>
    <FOCUS>Building robust, scalable systems for media operations</FOCUS>
    <CONSIDERATIONS>
      <ITEM>High availability requirements</ITEM>
      <ITEM>Data integrity critical for media content</ITEM>
      <ITEM>Performance considerations for content delivery</ITEM>
      <ITEM>Security requirements for media assets</ITEM>
    </CONSIDERATIONS>
  </BUSINESS_CONTEXT>
</PROJECT_CONTEXT>
