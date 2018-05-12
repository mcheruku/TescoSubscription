/*

	Author:			Saritha K
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[PackageExecutionHistory] and [tescosubscription].[PackageTransactionLog]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[PackageTransactionLog]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_PackageTransactionLog_PackageExecutionHistory_PackageExecutionHistoryID')
			BEGIN

		ALTER TABLE [tescosubscription].[PackageTransactionLog] WITH CHECK ADD  CONSTRAINT [FK_PackageTransactionLog_PackageExecutionHistory_PackageExecutionHistoryID] FOREIGN KEY([PackageExecutionHistoryID])
          REFERENCES [tescosubscription].[PackageExecutionHistory] ([PackageExecutionHistoryID])
				NOT FOR REPLICATION 

				ALTER TABLE [tescosubscription].[PackageTransactionLog] CHECK CONSTRAINT [FK_PackageTransactionLog_PackageExecutionHistory_PackageExecutionHistoryID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_PackageTransactionLog_PackageExecutionHistory_PackageExecutionHistoryID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_PackageTransactionLog_PackageExecutionHistory_PackageExecutionHistoryID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_PackageTransactionLog_PackageExecutionHistory_PackageExecutionHistoryID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_PackageTransactionLog_PackageExecutionHistory_PackageExecutionHistoryID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[PackageExecutionHistory]/[tescosubscription].[PackageTransactionLog] does not exist.',16,1)
	END
GO
