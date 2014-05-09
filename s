
[1mFrom:[0m /home/aq/projects/videoshow_v2/app/models/featured_video.rb @ line 79 FeaturedVideo#check_me:

     [1;34m78[0m: [32mdef[0m [1;34mcheck_me[0m
 =>  [1;34m79[0m:     [32mif[0m [1;36mself[0m.update_date.nil?
     [1;34m80[0m:       [1;36mself[0m.update_date = [1;34;4mDateTime[0m.now
     [1;34m81[0m:       [1;36mself[0m.save
     [1;34m82[0m:     [32mend[0m
     [1;34m83[0m: 
     [1;34m84[0m:     [32mif[0m [1;36mself[0m.update_date > [1;34m5[0m.minutes.ago
     [1;34m85[0m:       [1;36mself[0m.update_date = [1;34;4mDateTime[0m.now
     [1;34m86[0m:       [1;36mself[0m.save
     [1;34m87[0m: 
     [1;34m88[0m:       request3 = [1;34;4mTyphoeus[0m.get([31m[1;31m"[0m[31mhttps://api.instagram.com/v1/media/#{self.instagram_item[[1;31m'[0m[31mid[1;31m'[0m[31m[0m[31m]}[0m[31m[1;31m"[0m[31m[0m)
     [1;34m89[0m:       
     [1;34m90[0m:       [32mif[0m request3.code == [1;34m400[0m
     [1;34m91[0m:         [1;36mself[0m.delete
     [1;34m92[0m:         [32mreturn[0m [1;36mfalse[0m
     [1;34m93[0m:       [32melse[0m
     [1;34m94[0m:         request = [1;34;4mTyphoeus[0m.get([1;36mself[0m.instagram_item[[31m[1;31m'[0m[31mimages[1;31m'[0m[31m[0m][[31m[1;31m'[0m[31mthumbnail[1;31m'[0m[31m[0m][[31m[1;31m'[0m[31murl[1;31m'[0m[31m[0m])
     [1;34m95[0m:         request2 = [1;34;4mTyphoeus[0m.get([1;36mself[0m.instagram_item[[31m[1;31m'[0m[31muser[1;31m'[0m[31m[0m][[31m[1;31m'[0m[31mprofile_picture[1;31m'[0m[31m[0m])
     [1;34m96[0m:         [1;36mself[0m.update_item [32mif[0m request.code == [1;34m0[0m [32mor[0m request2.code == [1;34m0[0m
     [1;34m97[0m:         [32mreturn[0m [1;36mtrue[0m
     [1;34m98[0m:       [32mend[0m        
     [1;34m99[0m:     [32melse[0m
    [1;34m100[0m:       [32mreturn[0m [1;36mtrue[0m
    [1;34m101[0m:     [32mend[0m
    [1;34m102[0m: 
    [1;34m103[0m: [32mend[0m

