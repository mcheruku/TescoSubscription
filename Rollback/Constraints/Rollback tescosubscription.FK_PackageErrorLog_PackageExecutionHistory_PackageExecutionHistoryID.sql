/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		Rollback Foreign Key [tescosubscription].[FK_PackageErrorLog_PackageExecutionHistory_PackageExecutionHistoryID]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_PackageErrorLog_PackageExecutionHistory_PackageExecutionHistoryID]') 
	 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[PackageErrorLog]'))
	BEGIN

		ALTER TABLE [tescosubscription].[PackageErrorLog] DROP CONSTRAINT [FK_PackageErrorLog_PackageExecutionHistory_PackageExecutionHistoryID]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_PackageErrorLog_PackageExecutionHistory_PackageExecutionHistoryID]') 
		 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[PackageErrorLog]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [tescosubscription].[FK_PackageErrorLog_PackageExecutionHistory_PackageExecutionHistoryID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [tescosubscription].[FK_PackageErrorLog_PackageExecutionHistory_PackageExecutionHistoryID] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [tescosubscription].[FK_PackageErrorLog_PackageExecutionHistory_PackageExecutionHistoryID] does not exist.'
	END
GO
