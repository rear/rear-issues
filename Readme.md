# Relax-and-Recover (ReaR) Issues Collection Generator

This project aims at dumping all open and closed issues (and pull requests) from GitHub ReaR project in markdown files. 

We used the [gh2md](https://github.com/mattduck/gh2md) tool created by [Matt Duck](https://github.com/mattduck) to generate individual MarkDown pages of each issue and pull request (open or closed).

We packed this tool in a docker image generated via our [Dockerfile](https://github.com/rear/rear-issues/blob/main/Dockerfile) as

```bash
docker build -t gh2md .
```

We can view the image of the container via:

```bash
$ docker image ls
REPOSITORY       TAG       IMAGE ID       CREATED        SIZE
gh2md            latest    e87b6e655a50   17 hours ago   618MB
```

However, to start we must add some important parameters:

```bash
docker run -it -v $HOME/projects/rear/rear-user-guide:$HOME/web \
               -v $HOME/.gitconfig:$HOME/.gitconfig -v $HOME/.ssh:$HOME/.ssh \
               -v $HOME/.gnupg:$HOME/.gnupg -v $HOME/.github-token:$HOME/.github-token --net=host gh2md
```

The issues will be generated in directory `$HOME/projects/rear/rear-user-guide/docs/issues`, which is from the [ReaR User Guide](https://github.com/rear/rear-user-guide). When the container is done with dumping the issues it will exit the container and that's it.

```bash
$ docker ps -a
CONTAINER ID   IMAGE     COMMAND                  CREATED        STATUS                    PORTS     NAMES
46117c96b4d5   gh2md     "/bin/bash -o pipefa…"   17 hours ago   Exited (0) 17 hours ago             rear-issues
3e60e4a129ab   mkdocs    "bash"                   6 months ago   Exited (0) 17 hours ago             rug
```

Afterwards we can rerun the container with the command:

```bash
$ docker start -i rear-issues
[2023-06-15 08:09:22,466] [INFO] Creating output directory: issues
[2023-06-15 08:09:22,466] [INFO] Looking for token in envvar GITHUB_ACCESS_TOKEN
[2023-06-15 08:09:22,466] [INFO] Looking for token in file: /home/gdha/.config/gh2md/token
[2023-06-15 08:09:22,466] [INFO] Looking for token in file: /home/gdha/.github-token
[2023-06-15 08:09:22,466] [INFO] Using token from file: /home/gdha/.github-token
[2023-06-15 08:09:22,466] [INFO] Initiating fetch for repo: rear/rear
[2023-06-15 08:09:31,578] [INFO] Rate limit info after request: limit=5000, cost=4, remaining=4971, resetAt=2023-06-15T08:43:56Z
[2023-06-15 08:09:31,579] [INFO] Fetched repo page. total_requests_made=1, repo_issue_count=1862, repo_pr_count=1125 issue_cursor=Y3Vyc29yOnYyOpK5MjAyMi0wOC0xMlQxMzoyMjo0NSswMjowMM5Psk5a pr_cursor=Y3Vyc29yOnYyOpK5MjAyMi0wMi0wNFQyMTo1Mjo0NSswMTowMM4yGppN
[2023-06-15 08:09:45,510] [WARNING] Exception response from request attempt 1
Traceback (most recent call last):
  File "/usr/local/lib/python3.8/dist-packages/gh2md/gh2md.py", line 381, in _post
    resp.raise_for_status()
  File "/usr/local/lib/python3.8/dist-packages/requests/models.py", line 1021, in raise_for_status
    raise HTTPError(http_error_msg, response=self)
requests.exceptions.HTTPError: 502 Server Error: Bad Gateway for url: https://api.github.com/graphql
[2023-06-15 08:10:03,737] [WARNING] Exception response from request attempt 2
Traceback (most recent call last):
  File "/usr/local/lib/python3.8/dist-packages/gh2md/gh2md.py", line 381, in _post
    resp.raise_for_status()
  File "/usr/local/lib/python3.8/dist-packages/requests/models.py", line 1021, in raise_for_status
    raise HTTPError(http_error_msg, response=self)
requests.exceptions.HTTPError: 502 Server Error: Bad Gateway for url: https://api.github.com/graphql
[2023-06-15 08:10:06,738] [ERROR] Request failed multiple retries, returning empty data
[2023-06-15 08:10:06,845] [INFO] Retrieved issues for repo: rear/rear
[2023-06-15 08:10:06,845] [INFO] Retrieved issue counts: 
{'PRs': {'closed': 14, 'merged': 84, 'open': 2, 'total': 100},
 'issues': {'closed': 68, 'open': 32, 'total': 100},
 'total': 200}
[2023-06-15 08:10:06,845] [INFO] Converting retrieved issues to markdown
[2023-06-15 08:10:06,855] [INFO] Writing to file: issues/2023-06-12.3013.issue.open.gfm
[2023-06-15 08:10:06,855] [INFO] Writing to file: issues/2023-06-09.3012.issue.open.gfm
[2023-06-15 08:10:06,855] [INFO] Writing to file: issues/2023-06-09.3011.issue.open.gfm
[2023-06-15 08:10:06,855] [INFO] Writing to file: issues/2023-06-09.3010.issue.open.gfm
[2023-06-15 08:10:06,855] [INFO] Writing to file: issues/2023-06-08.3009.pr.merged.gfm
[2023-06-15 08:10:06,855] [INFO] Writing to file: issues/2023-06-08.3008.issue.closed.gfm
[2023-06-15 08:10:06,855] [INFO] Writing to file: issues/2023-06-07.3007.issue.open.gfm
[2023-06-15 08:10:06,855] [INFO] Writing to file: issues/2023-06-06.3006.pr.open.gfm
[2023-06-15 08:10:06,855] [INFO] Writing to file: issues/2023-06-05.3005.issue.open.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-06-05.3004.issue.open.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-06-02.3003.pr.merged.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-06-01.3002.pr.merged.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-06-01.3001.pr.merged.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-06-01.3000.issue.closed.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-31.2999.issue.closed.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-29.2998.pr.merged.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-26.2997.issue.open.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-26.2996.pr.merged.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-25.2995.issue.open.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-25.2994.issue.closed.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-25.2993.issue.open.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-25.2992.issue.open.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-24.2991.pr.merged.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-19.2990.issue.open.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-17.2989.issue.closed.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-14.2988.pr.merged.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-12.2987.issue.open.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-12.2986.pr.merged.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-11.2985.pr.merged.gfm
[2023-06-15 08:10:06,856] [INFO] Writing to file: issues/2023-05-10.2984.issue.closed.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-05-09.2983.issue.open.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-05-09.2982.pr.merged.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-05-05.2981.pr.merged.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-05-05.2980.pr.merged.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-05-04.2979.pr.closed.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-05-03.2978.issue.open.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-05-02.2977.issue.open.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-04-28.2976.pr.merged.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-04-27.2975.pr.merged.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-04-27.2974.pr.merged.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-04-25.2973.pr.merged.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-04-23.2972.issue.open.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-04-21.2971.issue.open.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-04-12.2970.issue.open.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-04-05.2968.issue.closed.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-04-05.2967.issue.open.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-04-04.2966.issue.open.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-04-02.2965.pr.merged.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-03-30.2964.issue.closed.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-03-28.2963.pr.merged.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-03-28.2962.issue.closed.gfm
[2023-06-15 08:10:06,857] [INFO] Writing to file: issues/2023-03-28.2961.pr.open.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-03-23.2959.issue.closed.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-03-20.2958.issue.open.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-03-15.2957.issue.closed.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-03-12.2956.pr.merged.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-03-07.2955.issue.closed.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-03-07.2954.pr.merged.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-03-06.2953.pr.merged.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-03-05.2952.issue.closed.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-03-04.2951.issue.open.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-03-01.2950.pr.merged.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-02-28.2949.pr.merged.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-02-24.2947.pr.merged.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-02-22.2946.pr.merged.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-02-22.2945.issue.closed.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-02-22.2944.issue.closed.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-02-21.2943.pr.merged.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-02-21.2942.issue.open.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-02-21.2941.issue.open.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-02-20.2940.issue.closed.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-02-19.2939.issue.closed.gfm
[2023-06-15 08:10:06,858] [INFO] Writing to file: issues/2023-02-18.2938.issue.closed.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-17.2937.pr.merged.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-16.2936.issue.closed.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-15.2934.pr.merged.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-15.2933.issue.open.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-15.2932.pr.merged.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-14.2931.pr.merged.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-14.2930.issue.closed.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-14.2929.issue.closed.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-14.2928.issue.open.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-14.2927.issue.closed.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-13.2926.issue.closed.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-13.2925.issue.closed.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-13.2924.issue.closed.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-13.2923.issue.closed.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-12.2922.issue.closed.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-10.2921.issue.closed.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-10.2920.issue.closed.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-02-07.2918.issue.closed.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-01-30.2917.issue.open.gfm
[2023-06-15 08:10:06,859] [INFO] Writing to file: issues/2023-01-20.2915.pr.merged.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2023-01-18.2914.issue.closed.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2023-01-17.2913.issue.closed.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2023-01-17.2912.issue.closed.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2023-01-16.2911.issue.closed.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2023-01-10.2910.pr.merged.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2023-01-10.2909.pr.merged.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2023-01-09.2908.issue.closed.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2023-01-08.2907.pr.merged.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2023-01-03.2906.issue.closed.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2023-01-03.2905.pr.merged.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2023-01-03.2904.pr.merged.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2023-01-02.2903.pr.merged.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2022-12-30.2902.issue.closed.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2022-12-28.2901.pr.merged.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2022-12-28.2900.issue.closed.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2022-12-28.2899.issue.closed.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2022-12-23.2898.issue.closed.gfm
[2023-06-15 08:10:06,860] [INFO] Writing to file: issues/2022-12-13.2897.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-12-05.2896.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-12-05.2895.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-12-04.2894.pr.merged.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-12-03.2893.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-11-30.2892.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-11-29.2891.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-11-22.2890.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-11-13.2889.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-11-13.2888.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-11-03.2887.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-11-02.2886.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-11-02.2885.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-10-26.2884.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-10-26.2883.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-10-20.2882.pr.merged.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-10-17.2881.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-10-12.2880.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-10-09.2879.pr.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-10-06.2878.pr.merged.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-10-06.2877.issue.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-10-04.2876.pr.merged.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-09-30.2875.issue.open.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-09-30.2874.pr.closed.gfm
[2023-06-15 08:10:06,861] [INFO] Writing to file: issues/2022-09-29.2873.pr.merged.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-29.2872.pr.merged.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-28.2871.issue.open.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-28.2870.issue.closed.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-27.2869.issue.closed.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-22.2868.pr.merged.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-22.2867.issue.open.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-21.2866.issue.closed.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-19.2865.issue.closed.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-16.2864.issue.closed.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-16.2863.issue.closed.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-15.2862.issue.closed.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-12.2859.pr.merged.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-07.2858.issue.closed.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-07.2857.pr.merged.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-06.2856.issue.closed.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-09-01.2855.pr.merged.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-08-31.2854.pr.closed.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-08-31.2853.issue.open.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-08-19.2852.issue.closed.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-08-12.2851.pr.merged.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-08-12.2850.issue.closed.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-08-09.2849.pr.merged.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-08-05.2847.pr.merged.gfm
[2023-06-15 08:10:06,862] [INFO] Writing to file: issues/2022-08-04.2846.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-07-28.2844.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-07-25.2842.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-07-14.2839.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-07-01.2834.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-06-29.2831.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-06-24.2830.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-06-24.2829.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-06-22.2828.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-06-22.2827.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-06-21.2825.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-06-16.2823.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-06-16.2822.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-06-13.2821.pr.closed.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-06-09.2819.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-06-04.2816.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-06-01.2815.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-06-01.2814.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-05-31.2813.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-05-23.2811.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-05-17.2808.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-05-10.2804.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-05-10.2803.pr.merged.gfm
[2023-06-15 08:10:06,863] [INFO] Writing to file: issues/2022-05-10.2802.pr.closed.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-05-06.2800.pr.merged.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-05-05.2797.pr.merged.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-05-03.2796.pr.closed.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-04-26.2795.pr.merged.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-04-21.2794.pr.closed.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-04-13.2791.pr.merged.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-04-13.2790.pr.merged.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-04-13.2789.pr.closed.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-04-11.2788.pr.closed.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-04-07.2786.pr.closed.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-04-04.2784.pr.closed.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-03-21.2776.pr.merged.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-03-16.2774.pr.merged.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-03-11.2771.pr.merged.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-03-08.2768.pr.merged.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-03-04.2763.pr.merged.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-02-08.2758.pr.closed.gfm
[2023-06-15 08:10:06,864] [INFO] Writing to file: issues/2022-02-04.2756.pr.closed.gfm
[2023-06-15 08:10:06,864] [INFO] Done.
$ 
```

To make the issues visible within the ReaR User Guide we need to start the container from the [Relax-and-Recover User Guide](https://github.com/rear/rear-user-guide) and check the results with `mkdocs serve` before performing a git commit/push.

## References

* [Disaster Recovery for our own ReaR upstream project](https://github.com/rear/rear/issues/3007)

* [github-workflow-backup-issues-as-a-markdown-file-in-your-repo](https://github.com/mattduck/gh2md#github-workflow-backup-issues-as-a-markdown-file-in-your-repo)
