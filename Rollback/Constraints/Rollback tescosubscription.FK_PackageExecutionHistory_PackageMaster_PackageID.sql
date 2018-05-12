/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		Rollback Foreign Key [tescosubscription].[FK_PackageExecutionHistory_PackageMaster_PackageID]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_PackageExecutionHistory_PackageMaster_PackageID]') 
	 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]'))
	BEGIN

		ALTER TABLE [tescosubscription].[PackageExecutionHistory] DROP CONSTRAINT [FK_PackageExecutionHistory_PackageMaster_PackageID]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_PackageExecutionHistory_PackageMaster_PackageID]') 
		 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [tescosubscription].[FK_PackageExecutionHistory_PackageMaster_PackageID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [tescosubscription].[FK_PackageExecutionHistory_PackageMaster_PackageID] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [tescosubscription].[FK_PackageExecutionHistory_PackageMaster_PackageID] does not exist.'
	END
GO
