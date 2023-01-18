object scmNom: TscmNom
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 402
  Width = 479
  object qryIsMemberInEvent: TFDQuery
    IndexFieldNames = 'EntrantID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @EventID AS INT;'
      'DECLARE @MemberID AS INT;'
      ''
      'SET @EventID = :EVENTID'
      'SET @MemberID = :MEMBERID;'
      ''
      'SELECT Entrant.EntrantID'
      'FROM Entrant'
      
        'INNER JOIN HeatIndividual ON Entrant.HeatID = HeatIndividual.Hea' +
        'tID'
      'INNER JOIN Event ON HeatIndividual.EventID = Event.EventID'
      'WHERE Entrant.MemberID = @MemberID AND Event.EventID = @EventID')
    Left = 248
    Top = 88
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 266
      end
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 83
      end>
  end
  object qryNomEvent: TFDQuery
    IndexFieldNames = 'EventID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Event'
    UpdateOptions.KeyFields = 'EventID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'SELECT [EventID]'
      '      ,[EventNum]'
      '      ,[SessionID]'
      '      ,[EventTypeID]'
      '      ,[StrokeID]'
      '      ,[DistanceID]'
      '      ,[EventStatusID]'
      '  FROM [SwimClubMeet].[dbo].[Event]'
      'WHERE [EventID] = :EVENTID')
    Left = 48
    Top = 104
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object qryIsMemberNominated: TFDQuery
    IndexFieldNames = 'NomineeID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet'
      'SELECT Nominee.NomineeID'
      'FROM Nominee'
      
        'WHERE Nominee.MemberID = :MEMBERID AND Nominee.EventID = :EVENTI' +
        'D')
    Left = 248
    Top = 144
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object cmdNominateMember: TFDCommand
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckUpdatable = False
    CommandText.Strings = (
      'USE [SwimClubMeet]'
      ''
      ''
      'INSERT INTO [dbo].[Nominee]'
      '           ([AutoBuildFlag]'
      '           ,[TTB]'
      '           ,[PB]'
      '           ,[MemberID]'
      '           ,[EventID]'
      '           ,[SeedTime])'
      '     VALUES'
      '           (0'
      '           ,NULL'
      '           ,NULL'
      '           ,:MemberID'
      '           ,:EventID'
      '           ,NULL)')
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    Left = 56
    Top = 24
  end
  object qryNomHeat: TFDQuery
    IndexesActive = False
    IndexFieldNames = 'HeatID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @MemberID AS INT'
      'DECLARE @EventID AS INT'
      ''
      'SET @MemberID = :MEMBERID;'
      'SET @EventID = :EVENTID;'
      ''
      'SELECT HeatIndividual.HeatID, HeatIndividual.HeatStatusID'
      'FROM [Event]'
      
        'INNER JOIN HeatIndividual ON [Event].EventID = HeatIndividual.Ev' +
        'entID'
      'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      'WHERE [Event].EventID = @EventID'
      #9'AND (Entrant.MemberID = @MemberID)')
    Left = 48
    Top = 176
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 17
      end
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 395
      end>
  end
  object cmdCleanLane: TFDCommand
    Connection = SCM.scmConnection
    CommandText.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @EntrantID AS INT'
      ''
      'SET @EntrantID = :ENTRANTID;'
      ''
      'UPDATE Entrant'
      '   SET [MemberID] = NULL'
      '      ,[RaceTime] = NULL'
      '      ,[TimeToBeat] = NULL'
      '      ,[PersonalBest] =NULL'
      '      ,[IsDisqualified] = 0'
      '      ,[IsScratched] = 0'
      'FROM Entrant'
      'WHERE EntrantID =  @EntrantID;')
    ParamData = <
      item
        Name = 'ENTRANTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
    Left = 256
    Top = 24
  end
  object cmdDeleteNominee: TFDCommand
    Connection = SCM.scmConnection
    CommandText.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @MemberID AS INT;'
      'DECLARE @EventID AS INT;'
      ''
      'SET @MemberID = :MEMBERID;'
      'SET @EventID = :EVENTID;'
      ''
      'DELETE FROM [dbo].[Nominee]'
      '      WHERE MemberID = @MemberID AND EventID = @EventID;'
      ';')
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
    Left = 160
    Top = 24
  end
  object qryNomEntrant: TFDQuery
    Connection = SCM.scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayTime]
    FormatOptions.FmtDisplayTime = 'nn:mm.zz'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE [SwimClubMeet]'
      ''
      'DECLARE @EntrantID INT'
      ''
      'SET @EntrantID = :ENTRANTID;'
      ''
      'SELECT [EntrantID]'
      '      ,[MemberID]'
      '      ,[Lane]'
      '      ,[RaceTime]'
      '      ,[TimeToBeat]'
      '      ,[PersonalBest]'
      '      ,[IsDisqualified]'
      '      ,[IsScratched]'
      '      ,Entrant.[HeatID]'
      ',HeatIndividual.EventID'
      ',HeatIndividual.HeatStatusID'
      ',HeatIndividual.HeatNum'
      ''
      '  FROM [dbo].[Entrant]'
      
        'INNER JOIN HeatIndividual on Entrant.HeatID = HeatIndividual.Hea' +
        'tID'
      'WHERE Entrant.EntrantID = @EntrantID')
    Left = 48
    Top = 248
    ParamData = <
      item
        Name = 'ENTRANTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2141
      end>
  end
  object qryGetEntrantID: TFDQuery
    IndexesActive = False
    IndexFieldNames = 'EntrantID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @EventID AS INT'
      'DECLARE @MemberID AS INT'
      ''
      ''
      'SET @EventID = :EVENTID;'
      'SET @MemberID = :MEMBERID;'
      ''
      'SELECT Entrant.EntrantID'
      '--,HeatIndividual.EventID'
      '--,HeatIndividual.HeatID '
      'FROM Event '
      
        'INNER JOIN HeatIndividual ON Event.EventID = HeatIndividual.Even' +
        'tID'
      'INNER JOIN Entrant ON HeatIndividual.HeatID = Entrant.HeatID'
      'WHERE Event.EventID = @EventID AND Entrant.MemberID = @MemberID;')
    Left = 392
    Top = 120
    ParamData = <
      item
        Name = 'EVENTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 189
      end
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 31
      end>
  end
  object cmdInsertEntrant: TFDCommand
    Connection = SCM.scmConnection
    CommandText.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @MemberID AS INTEGER;'
      'DECLARE @LaneNum AS INTEGER;'
      'DECLARE @HeatID AS INTEGER;'
      'DECLARE @DistanceID AS INTEGER;'
      'DECLARE @StrokeID AS INTEGER;'
      ''
      'SET @MemberID = :MEMBERID;'
      'SET @LaneNum = :LANENUM;'
      'SET @HeatID = :HEATID;'
      'SET @DistanceID = :DISTANCEID;'
      'SET @StrokeID = :STROKEID;'
      ''
      'INSERT INTO [dbo].[Entrant]'
      '           ([MemberID]'
      '           ,[Lane]'
      '           ,[RaceTime]'
      '           ,[TimeToBeat]'
      '           ,[PersonalBest]'
      '           ,[IsDisqualified]'
      '           ,[IsScratched]'
      '           ,[HeatID])'
      '     VALUES'
      '           (@MemberID'
      '           ,@LaneNum'
      '           ,NULL'
      
        '           ,dbo.TimeToBeat_DEFAULT(@MemberID, @DistanceID, @Stro' +
        'keID, default, default)'
      
        '           ,dbo.PersonalBest(@MemberID, @DistanceID, @StrokeID, ' +
        'default)'
      '           ,0'
      '           ,0'
      '           ,@HeatID);'
      '')
    ParamData = <
      item
        Name = 'MEMBERID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'LANENUM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'HEATID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DISTANCEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'STROKEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    Left = 344
    Top = 304
  end
  object qryGetEventID: TFDQuery
    IndexFieldNames = 'HeatID'
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @HeatID AS INTEGER;'
      ''
      'SET @HeatID = :HEATID;'
      ''
      'SELECT [HeatIndividual].[HeatID]'
      '      ,[HeatIndividual].[EventID]'
      ',Event.DistanceID'
      ',Event.StrokeID'
      '  FROM [dbo].[HeatIndividual]'
      'INNER JOIN Event ON [HeatIndividual].EventID = Event.EventID'
      '  WHERE [HeatIndividual].HeatID = @HeatID ;')
    Left = 392
    Top = 176
    ParamData = <
      item
        Name = 'HEATID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryIsLaneFilled: TFDQuery
    Connection = SCM.scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE [SwimClubMeet]'
      ';'
      'DECLARE @HeatID AS INTEGER;'
      'DECLARE @LaneNum as INTEGER;'
      'SET @HeatID = :HEATID;'
      'SET @LaneNum = :LANENUM;'
      ''
      ''
      'SELECT [MemberID]'
      '  FROM [dbo].[Entrant]'
      'WHERE Lane = @LaneNum AND HeatID = @HeatID;'
      ';')
    Left = 248
    Top = 200
    ParamData = <
      item
        Name = 'HEATID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1119
      end
      item
        Name = 'LANENUM'
        DataType = ftInteger
        ParamType = ptInput
        Value = 8
      end>
  end
  object cmdUpdateLane: TFDCommand
    CommandText.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @MemberID AS INTEGER;'
      'DECLARE @HeatID AS INTEGER;'
      'DECLARE @Lane AS INTEGER;'
      ''
      'SET @MemberID = :MEMBERID;'
      'SET @HeatID = :HEATID;'
      'SET @Lane = :LANE;'
      ''
      ''
      'UPDATE [dbo].[Entrant]'
      '   SET [MemberID] = @MemberID'
      ' WHERE HeatID = @HeatID AND Lane = @Lane;')
    ParamData = <
      item
        Name = 'MEMBERID'
        ParamType = ptInput
      end
      item
        Name = 'HEATID'
        ParamType = ptInput
      end
      item
        Name = 'LANE'
        ParamType = ptInput
      end>
    Left = 184
    Top = 304
  end
end
