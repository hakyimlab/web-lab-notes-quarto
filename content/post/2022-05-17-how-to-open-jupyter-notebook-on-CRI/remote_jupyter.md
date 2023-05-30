## Workflow

This is a workflow to show how to open jupyter notebook on CRI or RCC.
There are some detailed instructions here, [CRI’s
instructions](https://rcc.uchicago.edu/docs/software/environments/python/index.html)
and [More general
instructions](https://ljvmiranda921.github.io/notebook/2018/01/31/running-a-jupyter-notebook/)

### Remote side

Make sure you’ve installed the required Python modules and packages.

`$ ssh <username>@gardner.cri.uchicago.edu` <br/>

`$ jupyter notebook --no-browser --port=XXXX`

The default port will be 8888, and “–no-browser” is required because if
you do not specify –no-browser –ip=, the web browser will be launched on
the node and the URL returned cannot be used on your local machine.

If you set port=8889, the result should be like the following:

`To access the notebook, open this file in a browser:`<br/>
`file:///home/<username>/.local/share/jupyter/runtime/nbserver-129406-open.html`<br/>
`Or copy and paste one of these URLs:`<br/>
`http://localhost:8889/?token=47871f1a27e41715e04362540f5730611a30b17ae2072827`<br/>
`or http://127.0.0.1:8889/?token=47871f1a27e41715e04362540f5730611a30b17ae2072827`

### Local machine

Open a new terminal and run the following command.

`$ ssh -N -f -L localhost:YYYY:localhost:XXXX <username>@gardner.cri.uchicago.edu`

Select any port=YYYY which you haven’t used for other work.

Then open a browser, type in `localhost=<YYYY>` and copy and paste the
token from the last step.<br/> Finally, it should worked out.
