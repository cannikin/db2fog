# coding: utf-8

namespace :db2fog do
  namespace :backup do
    desc "Save a full back to S3"
    task :full => :environment do
      DB2Fog.new.full_backup
    end

    desc "Restore your DB from S3"
    task :restore => :environment do
      DB2Fog.new.restore
    end

    desc "Keep all backups for the last day, one per day for the last week, and one per week before that. Delete the rest."
    task :clean => :environment do
      DB2Fog.new.clean
    end
  end

  desc "Show table sizes for your database"
  task :statistics => :environment do
    rows = DB2Fog.new.statistics
    rows.sort_by {|x| -x[3].to_i }
    header = [["Type", "Data MB", "Index", "Rows", "Name"], []]
    puts (header + rows).collect {|x| x.join("\t") }
  end
end
