
[1mFrom:[0m /usr/local/rvm/gems/ruby-2.0.0-p451@videoshow/gems/journey-1.0.4/lib/journey/router.rb @ line 70 Journey::Router#call:

    [1;34m53[0m: [32mdef[0m [1;34mcall[0m env
    [1;34m54[0m:   env[[31m[1;31m'[0m[31mPATH_INFO[1;31m'[0m[31m[0m] = [1;34;4mUtils[0m.normalize_path env[[31m[1;31m'[0m[31mPATH_INFO[1;31m'[0m[31m[0m]
    [1;34m55[0m: 
    [1;34m56[0m:   find_routes(env).each [32mdo[0m |match, parameters, route|
    [1;34m57[0m:     script_name, path_info, set_params = env.values_at([31m[1;31m'[0m[31mSCRIPT_NAME[1;31m'[0m[31m[0m,
    [1;34m58[0m:                                                        [31m[1;31m'[0m[31mPATH_INFO[1;31m'[0m[31m[0m,
    [1;34m59[0m:                                                        @params_key)
    [1;34m60[0m: 
    [1;34m61[0m:     [32munless[0m route.path.anchored
    [1;34m62[0m:       env[[31m[1;31m'[0m[31mSCRIPT_NAME[1;31m'[0m[31m[0m] = (script_name.to_s + match.to_s).chomp([31m[1;31m'[0m[31m/[1;31m'[0m[31m[0m)
    [1;34m63[0m:       env[[31m[1;31m'[0m[31mPATH_INFO[1;31m'[0m[31m[0m]   = [1;34;4mUtils[0m.normalize_path(match.post_match)
    [1;34m64[0m:     [32mend[0m
    [1;34m65[0m: 
    [1;34m66[0m:     env[@params_key] = (set_params || {}).merge parameters
    [1;34m67[0m: 
    [1;34m68[0m:     status, headers, body = route.app.call(env)
    [1;34m69[0m: 
 => [1;34m70[0m:     [32mif[0m [31m[1;31m'[0m[31mpass[1;31m'[0m[31m[0m == headers[[31m[1;31m'[0m[31mX-Cascade[1;31m'[0m[31m[0m]
    [1;34m71[0m:       env[[31m[1;31m'[0m[31mSCRIPT_NAME[1;31m'[0m[31m[0m] = script_name
    [1;34m72[0m:       env[[31m[1;31m'[0m[31mPATH_INFO[1;31m'[0m[31m[0m]   = path_info
    [1;34m73[0m:       env[@params_key]   = set_params
    [1;34m74[0m:       [32mnext[0m
    [1;34m75[0m:     [32mend[0m
    [1;34m76[0m: 
    [1;34m77[0m:     [32mreturn[0m [status, headers, body]
    [1;34m78[0m:   [32mend[0m
    [1;34m79[0m: 
    [1;34m80[0m:   [32mreturn[0m [[1;34m404[0m, {[31m[1;31m'[0m[31mX-Cascade[1;31m'[0m[31m[0m => [31m[1;31m'[0m[31mpass[1;31m'[0m[31m[0m}, [[31m[1;31m'[0m[31mNot Found[1;31m'[0m[31m[0m]]
    [1;34m81[0m: [32mend[0m

