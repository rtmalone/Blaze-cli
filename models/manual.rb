class Manual < ActiveRecord::Base

  def self.print_man
    puts"      About Trail Classes:
        - Blaze-cli utilizes the trail classification scale defined by the U.S. Forest Service.

        - Trails are classified 1-5; Class 1 indicates very rough terrain and the trail may not even be marked.
          Class 5 trails will be fully paved and almost completely level.

        - For further details on U.S Forest Service trail classes visit:
          http://www.fs.fed.us/recreation/programs/trail-management/trail-fundamentals/National_Trail_Class_Matrix_10_16_2008.pdf".magenta
  end
end
