[+ AutoGen5 template sql +]
-- Database definition file for the chronology software
--
-- Created from an AutoGen defintion file from: [+ creation_date +]
-- Date of last update of defintion file: [+ last_update_on +]
--
-- Following are definitions to be used with SQLite3.


[+ FOR table "\n" +]DROP TABLE IF EXISTS [+ name +];
CREATE TABLE [+ name +] ( [+ 
	FOR attribute "," +][+ 
		compile_column +][+
	ENDFOR attribute +]
	[+ IF primary_key +],
	PRIMARY KEY ([+ primary_key +])
	[+ ENDIF +]
);
[+ ENDFOR table +]
[+ FOR triggers +]
DROP TRIGGER IF EXISTS [+ operation +]_abortion_on_[+ table +][+ 
	(sprintf "%d" (for-index)) +];
CREATE TRIGGER [+ operation +]_abortion_on_[+ table +][+ 
	(sprintf "%d" (for-index)) +] BEFORE [+ 
	(get-up-name "operation") +] ON [+ table +]
	FOR EACH ROW
	WHEN [+ condition +]
	BEGIN
		SELECT RAISE (ABORT, "Failure at [+ 
		(get-up-name "operation") +]-Operation on [+ 
		table +]: [+ message +]");
	END;
[+ ENDFOR triggers +][+
FOR data_modification_triggers +]
DROP TRIGGER IF EXISTS [+ operation +]_data_modifications_on_[+ table
	+][+ (sprintf "%d" (for-index)) +];
CREATE TRIGGER [+ operation +]_data_modifications_on_[+ table +][+ 
	(sprintf "%d" (for-index)) +] BEFORE [+ 
	(get-up-name "operation") +] ON [+ table +]
	FOR EACH ROW
	BEGIN
		[+ FOR instruction +][+
		instruction +];
		[+ ENDFOR instruction +]
	END;
[+ ENDFOR data_modification_triggers +][+
FOR index +]DROP INDEX IF EXISTS [+ table +]_[+ name +];
CREATE [+ IF unique +]UNIQUE [+ ENDIF +]INDEX [+ table +]_[+ name
	+] ON [+ table +] ([+
	FOR column "," +][+ column +][+ ENDFOR column +]);
[+ ENDFOR +][+
define compile_column +]
	[+ name +]	[+ type +][+ 
	IF length +] ([+ length +])[+ ENDIF +][+
	IF unique +] UNIQUE[+ ENDIF +][+ 
	IF not_null +] NOT NULL[+ ENDIF +][+ 
	IF default_value +] DEFAULT [+ default_value +][+ ENDIF +][+ 
	IF references_table +] REFERENCES [+ references_table
	+] ([+ references_attribute +])[+ ENDIF +][+ 
	IF check +] CHECK ([+ check +])[+ ENDIF +][+
enddef +]

.read tests.sql
