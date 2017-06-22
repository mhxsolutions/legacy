The purpose of this set of files is to speed the creation of new client web 
sites. I've stuck with an approach that includes the files you need to add
to a new ASP.NET web application project, with an eye toward automatically
generating a complete new site from this set of files using CodeSmith. The 
CodeSmith friendly names I've used in this set of templates are:

	<%= this.WebSiteShortName %>	Web site short name like "Hydra", "TTL", etc.
	<%= this.SqlShortName %>	SQL short name, used for [NAME User Details] table access
	<%= this.ClientAddressLine1 %>	Client address: number and street
	<%= this.ClientAddressLine2 %>	Client address: city, state and zip
	<%= this.ClientName %>		Full name of the client (e.g., "Hydra Transport")
	<%= this.MembershipAppName %>	Name used for the ASP.NET authentication app name

Having said that, the tasks to create a new client web site using these templates are roughly:

	1. Create the new solution in the solutions folder and move it as needed
	2. Create a new ASP.NET web application project named "Web" in a new source folder
	3. Copy the contents of the template into the C:\Temp folder
	4. Edit the SlickEdit macro for replacing client web contents with the right data
	5. Run that SlickEdit macro and check the replacements
	6. Rename the few master files that need to be in place
	7. Add the binary deployable assemblies custom target to the new web project file
	8. Copy the files across selectively and use the IDE to add existing items

This set of instructions has been refined after partially working for UPA.