/*

	Author:			Saritha K
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[PackageMaster] and [tescosubscription].[PackageExecutionHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PackageMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_PackageExecutionHistory_PackageMaster_PackageID')
			BEGIN

		ALTER TABLE [tescosubscription].[PackageExecutionHistory] WITH CHECK ADD  CONSTRAINT [FK_PackageExecutionHistory_PackageMaster_PackageID] FOREIGN KEY([PackageID])
          REFERENCES [tescosubscription].[PackageMaster] ([PackageID])
				NOT FOR REPLICATION 

				ALTER TABLE [tescosubscription].[PackageExecutionHistory] CHECK CONSTRAINT [FK_PackageExecutionHistory_PackageMaster_PackageID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_PackageExecutionHistory_PackageMaster_PackageID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_PackageExecutionHistory_PackageMaster_PackageID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_PackageExecutionHistory_PackageMaster_PackageID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_PackageExecutionHistory_PackageMaster_PackageID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[PackageMaster]/[tescosubscription].[PackageExecutionHistory] does not exist.',16,1)
	END
GO
