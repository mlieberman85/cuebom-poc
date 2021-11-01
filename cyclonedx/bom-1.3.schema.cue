package cyclonedx

import (
	"list"
)

#CycloneDXBom: {
	// CycloneDX Software Bill-of-Material Specification
	@jsonschema(schema="http://json-schema.org/draft-07/schema#")
	@jsonschema(id="http://cyclonedx.org/schema/bom-1.3.schema.json")

	// BOM Format
	//
	// Specifies the format of the BOM. This helps to identify the
	// file as CycloneDX since BOMs do not have a filename convention
	// nor does JSON schema support namespaces.
	bomFormat: "CycloneDX"

	// CycloneDX Specification Version
	//
	// The version of the CycloneDX specification a BOM is written to
	// (starting at version 1.2)
	specVersion: string

	// BOM Serial Number
	//
	// Every BOM generated should have a unique serial number, even if
	// the contents of the BOM being generated have not changed over
	// time. The process or tool responsible for creating the BOM
	// should create random UUID's for every BOM generated.
	serialNumber?: =~"^urn:uuid:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$"

	// BOM Version
	//
	// The version allows component publishers/authors to make changes
	// to existing BOMs to update various aspects of the document
	// such as description or licenses. When a system is presented
	// with multiple BOMs for the same component, the system should
	// use the most recent version of the BOM. The default version is
	// '1' and should be incremented for each version of the BOM that
	// is published. Each version of a component should have a unique
	// BOM and if no changes are made to the BOMs, then each BOM will
	// have a version of '1'.
	version: int | *1

	// BOM Metadata
	//
	// Provides additional information about a BOM.
	metadata?: #metadata

	// Components
	components?: list.UniqueItems() & [...#component]

	// Services
	services?: list.UniqueItems() & [...#service]

	// External References
	//
	// External references provide a way to document systems, sites,
	// and information that may be relevant but which are not
	// included with the BOM.
	externalReferences?: [...#externalReference]

	// Dependencies
	//
	// Provides the ability to document dependency relationships.
	dependencies?: list.UniqueItems() & [...#dependency]

	// Compositions
	//
	// Compositions describe constituent parts (including components,
	// services, and dependency relationships) and their
	// completeness.
	compositions?: list.UniqueItems() & [...#compositions]

	#metadata: {
		// Timestamp
		//
		// The date and time (timestamp) when the document was created.
		timestamp?: string

		// Creation Tools
		//
		// The tool(s) used in the creation of the BOM.
		tools?: [...#tool]

		// Authors
		//
		// The person(s) who created the BOM. Authors are common in BOMs
		// created through manual processes. BOMs created through
		// automated means may not have authors.
		authors?: [...#organizationalContact]

		// Component
		//
		// The component that the BOM describes.
		component?: #component

		// Manufacture
		//
		// The organization that manufactured the component that the BOM
		// describes.
		manufacture?: #organizationalEntity

		// Supplier
		//
		// The organization that supplied the component that the BOM
		// describes. The supplier may often be the manufacturer, but may
		// also be a distributor or repackager.
		supplier?: #organizationalEntity

		// BOM License(s)
		licenses?: [...#licenseChoice]

		// Properties
		//
		// Provides the ability to document properties in a name-value
		// store. This provides flexibility to include data not
		// officially supported in the standard without having to use
		// additional namespaces or create extensions. Unlike key-value
		// stores, properties support duplicate names, each potentially
		// having different values.
		properties?: [...#property]
		...
	}

	#tool: {
		// Tool Vendor
		//
		// The date and time (timestamp) when the document was created.
		vendor?: string

		// Tool Name
		//
		// The date and time (timestamp) when the document was created.
		name?: string

		// Tool Version
		//
		// The date and time (timestamp) when the document was created.
		version?: string

		// Hashes
		//
		// The hashes of the tool (if applicable).
		hashes?: [...#hash]
		...
	}

	#organizationalEntity: {
		// Name
		//
		// The name of the organization
		name?: string

		// URL
		//
		// The URL of the organization. Multiple URLs are allowed.
		url?: [...string]

		// Contact
		//
		// A contact at the organization. Multiple contacts are allowed.
		contact?: [...#organizationalContact]
		...
	}

	#organizationalContact: {
		// Name
		//
		// The name of a contact
		name?: string

		// Email Address
		//
		// The email address of the contact.
		email?: string

		// Phone
		//
		// The phone number of the contact.
		phone?: string
		...
	}

	#component: {
		// Component Type
		//
		// Specifies the type of component. For software components,
		// classify as application if no more specific appropriate
		// classification is available or cannot be determined for the
		// component.
		type: "application" | "framework" | "library" | "container" | "operating-system" | "device" | "firmware" | "file"

		// Mime-Type
		//
		// The optional mime-type of the component. When used on file
		// components, the mime-type can provide additional context about
		// the kind of file being represented such as an image, font, or
		// executable. Some library or framework components may also have
		// an associated mime-type.
		"mime-type"?: =~"^[-+a-z0-9.]+/[-+a-z0-9.]+$"

		// BOM Reference
		//
		// An optional identifier which can be used to reference the
		// component elsewhere in the BOM. Every bom-ref should be
		// unique.
		"bom-ref"?: string

		// Component Supplier
		//
		// The organization that supplied the component. The supplier may
		// often be the manufacturer, but may also be a distributor or
		// repackager.
		supplier?: #organizationalEntity

		// Component Author
		//
		// The person(s) or organization(s) that authored the component
		author?: string

		// Component Publisher
		//
		// The person(s) or organization(s) that published the component
		publisher?: string

		// Component Group
		//
		// The grouping name or identifier. This will often be a
		// shortened, single name of the company or project that produced
		// the component, or the source package or domain name.
		// Whitespace and special characters should be avoided. Examples
		// include: apache, org.apache.commons, and apache.org.
		group?: string

		// Component Name
		//
		// The name of the component. This will often be a shortened,
		// single name of the component. Examples: commons-lang3 and
		// jquery
		name: string

		// Component Version
		//
		// The component version. The version should ideally comply with
		// semantic versioning but is not enforced.
		version: string

		// Component Description
		//
		// Specifies a description for the component
		description?: string

		// Component Scope
		//
		// Specifies the scope of the component. If scope is not
		// specified, 'required' scope should be assumed by the consumer
		// of the BOM
		scope?: "required" | "optional" | "excluded" | *"required"

		// Component Hashes
		hashes?: [...#hash]

		// Component License(s)
		licenses?: [...#licenseChoice]

		// Component Copyright
		//
		// An optional copyright notice informing users of the underlying
		// claims to copyright ownership in a published work.
		copyright?: string

		// Component Common Platform Enumeration (CPE)
		//
		// DEPRECATED - DO NOT USE. This will be removed in a future
		// version. Specifies a well-formed CPE name. See
		// https://nvd.nist.gov/products/cpe
		cpe?: string

		// Component Package URL (purl)
		purl?: string

		// SWID Tag
		//
		// Specifies metadata and content for ISO-IEC 19770-2 Software
		// Identification (SWID) Tags.
		swid?: #swid

		// Component Modified From Original
		//
		// DEPRECATED - DO NOT USE. This will be removed in a future
		// version. Use the pedigree element instead to supply
		// information on exactly how the component was modified. A
		// boolean value indicating is the component has been modified
		// from the original. A value of true indicates the component is
		// a derivative of the original. A value of false indicates the
		// component has not been modified from the original.
		modified?: bool

		// Component Pedigree
		//
		// Component pedigree is a way to document complex supply chain
		// scenarios where components are created, distributed, modified,
		// redistributed, combined with other components, etc. Pedigree
		// supports viewing this complex chain from the beginning, the
		// end, or anywhere in the middle. It also provides a way to
		// document variants where the exact relation may not be known.
		pedigree?: {
			// Ancestors
			//
			// Describes zero or more components in which a component is
			// derived from. This is commonly used to describe forks from
			// existing projects where the forked version contains a ancestor
			// node containing the original component it was forked from. For
			// example, Component A is the original component. Component B is
			// the component being used and documented in the BOM. However,
			// Component B contains a pedigree node with a single ancestor
			// documenting Component A - the original component from which
			// Component B is derived from.
			ancestors?: [...#component]

			// Descendants
			//
			// Descendants are the exact opposite of ancestors. This provides
			// a way to document all forks (and their forks) of an original
			// or root component.
			descendants?: [...#component]

			// Variants
			//
			// Variants describe relations where the relationship between the
			// components are not known. For example, if Component A contains
			// nearly identical code to Component B. They are both related,
			// but it is unclear if one is derived from the other, or if they
			// share a common ancestor.
			variants?: [...#component]

			// Commits
			//
			// A list of zero or more commits which provide a trail describing
			// how the component deviates from an ancestor, descendant, or
			// variant.
			commits?: [...#commit]

			// Patches
			//
			// >A list of zero or more patches describing how the component
			// deviates from an ancestor, descendant, or variant. Patches may
			// be complimentary to commits or may be used in place of
			// commits.
			patches?: [...#patch]

			// Notes
			//
			// Notes, observations, and other non-structured commentary
			// describing the components pedigree.
			notes?: string
			...
		}

		// External References
		externalReferences?: [...#externalReference]

		// Components
		components?: list.UniqueItems() & [...#component]

		// Evidence
		//
		// Provides the ability to document evidence collected through
		// various forms of extraction or analysis.
		evidence?: #componentEvidence

		// Properties
		//
		// Provides the ability to document properties in a name-value
		// store. This provides flexibility to include data not
		// officially supported in the standard without having to use
		// additional namespaces or create extensions. Unlike key-value
		// stores, properties support duplicate names, each potentially
		// having different values.
		properties?: [...#property]
		...
	}

	#swid: {
		// Tag ID
		//
		// Maps to the tagId of a SoftwareIdentity.
		tagId: string

		// Name
		//
		// Maps to the name of a SoftwareIdentity.
		name: string

		// Version
		//
		// Maps to the version of a SoftwareIdentity.
		version?: string | *"0.0"

		// Tag Version
		//
		// Maps to the tagVersion of a SoftwareIdentity.
		tagVersion?: int | *0

		// Patch
		//
		// Maps to the patch of a SoftwareIdentity.
		patch?: bool | *false

		// Attachment text
		//
		// Specifies the metadata and content of the SWID tag.
		text?: #attachment

		// URL
		//
		// The URL to the SWID file.
		url?: string
		...
	}

	#attachment: {
		// Content-Type
		//
		// Specifies the content type of the text. Defaults to text/plain
		// if not specified.
		contentType?: string | *"text/plain"

		// Encoding
		//
		// Specifies the optional encoding the text is represented in.
		encoding?: "base64"

		// Attachment Text
		//
		// The attachment data
		content: string
		...
	}

	#hash: {
		alg:     #["hash-alg"]
		content: #["hash-content"]
		...
	}

	#: "hash-alg": "MD5" | "SHA-1" | "SHA-256" | "SHA-384" | "SHA-512" | "SHA3-256" | "SHA3-384" | "SHA3-512" | "BLAKE2b-256" | "BLAKE2b-384" | "BLAKE2b-512" | "BLAKE3"

	#: "hash-content": =~"^([a-fA-F0-9]{32}|[a-fA-F0-9]{40}|[a-fA-F0-9]{64}|[a-fA-F0-9]{96}|[a-fA-F0-9]{128})$"

	#license: ({
		id: _
		...
	} | {
		name: _
		...
	}) & {
		// License ID (SPDX)
		//
		// A valid SPDX license ID
		id?: #spdxLicense

		// License Name
		//
		// If SPDX does not define the license used, this field may be
		// used to provide the license name
		name?: string

		// License text
		//
		// An optional way to include the textual content of a license.
		text?: #attachment

		// License URL
		//
		// The URL to the license file. If specified, a 'license'
		// externalReference should also be specified for completeness
		url?: string
		...
	}

	#licenseChoice: ({
		license: _
		...
	} | {
		expression: _
		...
	}) & {
		license?: #license

		// SPDX License Expression
		expression?: string
		...
	}

	#commit: {
		// UID
		//
		// A unique identifier of the commit. This may be version control
		// specific. For example, Subversion uses revision numbers
		// whereas git uses commit hashes.
		uid?: string

		// URL
		//
		// The URL to the commit. This URL will typically point to a
		// commit in a version control system.
		url?: string

		// Author
		//
		// The author who created the changes in the commit
		author?: #identifiableAction

		// Committer
		//
		// The person who committed or pushed the commit
		committer?: #identifiableAction

		// Message
		//
		// The text description of the contents of the commit
		message?: string
		...
	}

	#patch: {
		// Type
		//
		// Specifies the purpose for the patch including the resolution of
		// defects, security issues, or new behavior or functionality
		type: "unofficial" | "monkey" | "backport" | "cherry-pick"

		// Diff
		//
		// The patch file (or diff) that show changes. Refer to
		// https://en.wikipedia.org/wiki/Diff
		diff?: #diff

		// Resolves
		//
		// A collection of issues the patch resolves
		resolves?: [...#issue]
		...
	}

	#diff: {
		// Diff text
		//
		// Specifies the optional text of the diff
		text?: #attachment

		// URL
		//
		// Specifies the URL to the diff
		url?: string
		...
	}

	#issue: {
		// Type
		//
		// Specifies the type of issue
		type: "defect" | "enhancement" | "security"

		// ID
		//
		// The identifier of the issue assigned by the source of the issue
		id?: string

		// Name
		//
		// The name of the issue
		name?: string

		// Description
		//
		// A description of the issue
		description?: string

		// Source
		//
		// The source of the issue where it is documented
		source?: {
			// Name
			//
			// The name of the source. For example 'National Vulnerability
			// Database', 'NVD', and 'Apache'
			name?: string

			// URL
			//
			// The url of the issue documentation as provided by the source
			url?: string
			...
		}

		// References
		//
		// A collection of URL's for reference. Multiple URLs are allowed.
		references?: [...string]
		...
	}

	#identifiableAction: {
		// Timestamp
		//
		// The timestamp in which the action occurred
		timestamp?: string

		// Name
		//
		// The name of the individual who performed the action
		name?: string

		// E-mail
		//
		// The email address of the individual who performed the action
		email?: string
		...
	}

	#externalReference: {
		// URL
		//
		// The URL to the external reference
		url: string

		// Comment
		//
		// An optional comment describing the external reference
		comment?: string

		// Type
		//
		// Specifies the type of external reference. There are built-in
		// types to describe common references. If a type does not exist
		// for the reference being referred to, use the "other" type.
		type: "vcs" | "issue-tracker" | "website" | "advisories" | "bom" | "mailing-list" | "social" | "chat" | "documentation" | "support" | "distribution" | "license" | "build-meta" | "build-system" | "other"

		// Hashes
		//
		// The hashes of the external reference (if applicable).
		hashes?: [...#hash]
		...
	}

	#dependency: {
		// Reference
		//
		// References a component by the components bom-ref attribute
		ref: string

		// Depends On
		//
		// The bom-ref identifiers of the components that are dependencies
		// of this dependency object.
		dependsOn?: list.UniqueItems() & [...string]
		...
	}

	#service: {
		// BOM Reference
		//
		// An optional identifier which can be used to reference the
		// service elsewhere in the BOM. Every bom-ref should be unique.
		"bom-ref"?: string

		// Provider
		//
		// The organization that provides the service.
		provider?: #organizationalEntity

		// Service Group
		//
		// The grouping name, namespace, or identifier. This will often be
		// a shortened, single name of the company or project that
		// produced the service or domain name. Whitespace and special
		// characters should be avoided.
		group?: string

		// Service Name
		//
		// The name of the service. This will often be a shortened, single
		// name of the service.
		name: string

		// Service Version
		//
		// The service version.
		version?: string

		// Service Description
		//
		// Specifies a description for the service
		description?: string

		// Endpoints
		//
		// The endpoint URIs of the service. Multiple endpoints are
		// allowed.
		endpoints?: [...string]

		// Authentication Required
		//
		// A boolean value indicating if the service requires
		// authentication. A value of true indicates the service requires
		// authentication prior to use. A value of false indicates the
		// service does not require authentication.
		authenticated?: bool

		// Crosses Trust Boundary
		//
		// A boolean value indicating if use of the service crosses a
		// trust zone or boundary. A value of true indicates that by
		// using the service, a trust boundary is crossed. A value of
		// false indicates that by using the service, a trust boundary is
		// not crossed.
		"x-trust-boundary"?: bool

		// Data Classification
		//
		// Specifies the data classification.
		data?: [...#dataClassification]

		// Component License(s)
		licenses?: [...#licenseChoice]

		// External References
		externalReferences?: [...#externalReference]

		// Services
		services?: list.UniqueItems() & [...#service]

		// Properties
		//
		// Provides the ability to document properties in a name-value
		// store. This provides flexibility to include data not
		// officially supported in the standard without having to use
		// additional namespaces or create extensions. Unlike key-value
		// stores, properties support duplicate names, each potentially
		// having different values.
		properties?: [...#property]
		...
	}

	#dataClassification: {
		flow:           #dataFlow
		classification: string
		...
	}

	#dataFlow: "inbound" | "outbound" | "bi-directional" | "unknown"

	#copyright: {
		// Copyright Text
		text: string
		...
	}

	#componentEvidence: {
		// Component License(s)
		licenses?: [...#licenseChoice]

		// Copyright
		copyright?: [...#copyright]
		...
	}

	#compositions: {
		// Aggregate
		//
		// Specifies an aggregate type that describe how complete a
		// relationship is.
		aggregate: #aggregateType

		// BOM references
		//
		// The bom-ref identifiers of the components or services being
		// described. Assemblies refer to nested relationships whereby a
		// constituent part may include other constituent parts.
		// References do not cascade to child parts. References are
		// explicit for the specified constituent part only.
		assemblies?: list.UniqueItems() & [...string]

		// BOM references
		//
		// The bom-ref identifiers of the components or services being
		// described. Dependencies refer to a relationship whereby an
		// independent constituent part requires another independent
		// constituent part. References do not cascade to transitive
		// dependencies. References are explicit for the specified
		// dependency only.
		dependencies?: list.UniqueItems() & [...string]
		...
	}

	#aggregateType: "complete" | "incomplete" | "incomplete_first_party_only" | "incomplete_third_party_only" | "unknown" | "not_specified" | *"not_specified"

	#property: {
		// Name
		//
		// The name of the property. Duplicate names are allowed, each
		// potentially having a different value.
		name?: string

		// Value
		//
		// The value of the property.
		value?: string
		...
	}
	...
}
