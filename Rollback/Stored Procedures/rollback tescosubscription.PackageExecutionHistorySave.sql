/*
	Author:		Saritha K
	Created:	28 jul 2011
	Purpose:	This script to drop the procedure [tescosubscription].[PackageExecutionHistorySave]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistorySave]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[PackageExecutionHistorySave]

		IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistorySave]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[PackageExecutionHistorySave] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[PackageExecutionHistorySave] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[PackageExecutionHistorySave] - Not exists'
	END 
GO



