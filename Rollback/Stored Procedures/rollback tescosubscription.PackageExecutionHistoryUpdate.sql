/*
	Author:		Saritha K
	Created:	28 jul 2011
	Purpose:	This script to drop the procedure [tescosubscription].[PackageExecutionHistoryUpdate]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryUpdate]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[PackageExecutionHistoryUpdate]

		IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[PackageExecutionHistoryUpdate] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[PackageExecutionHistoryUpdate] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[PackageExecutionHistoryUpdate] - Not exists'
	END 
GO



