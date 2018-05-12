IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryCreate]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[PackageExecutionHistoryCreate]

		IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryCreate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[PackageExecutionHistoryCreate] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[PackageExecutionHistoryCreate] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[PackageExecutionHistoryCreate] - Not exists'
	END 
GO

		