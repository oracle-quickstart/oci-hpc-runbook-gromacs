# <img src="https://github.com/oci-hpc/oci-hpc-runbook-gromacs/blob/master/images/gromacs-logo.png" height="80" width="220"> Runbook

## Introduction
This Runbook provides the steps to deploy a GPU machine on Oracle Cloud Infrastructure, install Gromacs, and run a benchmark using Gromacs software.  

Gromacs is a molecular dynamics software that simulates the movements of atoms in biomolecules under a predefined set of conditions.  It is used to identify the behavior of these biomolecules when exposed to changes in temperature, pressure and other inputs that mimic the actual conditions encountered in a living organism.  Gromacs can be used to establish patterns in protein folding, protein-ligand binding, and cell membrane transport, making it a very useful application for drug research and discovery.

Gromacs supports running on CPU's or GPU's and supports parallel processing. It was developed by the University of Gronigen and is now maintained by various contributors around the world. More information can be found [here](http://www.gromacs.org/).

<img align="center" src="https://github.com/oci-hpc/oci-hpc-runbook-gromacs/blob/master/images/6LU7_Covid-19.gif" height="180" > 

## Architecture
The architecture for this runbook is simple, a single machine running inside of an OCI VCN with a public subnet.  
Since a GPU instance is used, block storage is attached to the instance and installed with the Gromacs application. 
The instance is located in a public subnet and assigned a public ip, which can be accessed via ssh.
<img src="https://github.com/oci-hpc/oci-hpc-runbook-gromacs/blob/master/images/GPU_arch_draft.png" height ="580" width="1200">

## Login
Login to the using opc as a username:
```
   ssh {username}\@{bm-public-ip-address} -i id_rsa
```
Note that if you are using resource manager, obtain the private key from the output and save on your local machine. 

## Deployment

Deploying this architecture on OCI can be done in different ways:
* The [resource Manager](https://github.com/oci-hpc/oci-hpc-runbook-gromacs/blob/master/Documentation/ResourceManager.md#deployment-through-resource-manager) let you deploy the infrastructure from the console. Only relevant variables are shown but others can be changed in the zip file. 
* The [web console](https://github.com/oci-hpc/oci-hpc-runbook-gromacs/blob/master/Documentation/ManualDeployment.md#deployment-via-web-console) let you create each piece of the architecture one by one from a webbrowser. This can be used to avoid any terraform scripting or using existing templates. 

## Licensing
See [Third Party Licenses](https://github.com/oci-hpc/oci-hpc-runbook-gromacs/blob/master/Third_Party_Licenses) for Gromacs and terraform licensing, including dependencies used in this tutorial.

## Running the Application
If the provided terraform scripts are used to launch the application, Gromacs is installed in the /mnt/block/Gromacs folder and the example benchmarking model is available in /mnt/block/work folder. Run Gromacs via the following commands:

1. Run Gromacs on OCI GPU shapes via the following command:
   ```
    gmx mdrun -s <file path> -ntmpi <# of cores> -gpu_id <GPU devices to use>
   ```
   where:
     * mdrun = program that reads the input file and execues the computational chemistry analysis
     * -s = the input file
     * -ntmpi = the number of thread-MPI threads to start 
     * -gpu_id = the string of digits (without delimiter) representing device id-s of the GPUs to be used

   Example for BM.GPU2.2:
   ```
   gmx mdrun -s gromacs_benchMEM.tpr -ntmpi 24 -gpu_id 01
   ```

   Example for BM.GPU3.8:
   ```
   gmx mdrun -s gromacs_benchMEM.tpr -ntmpi 48 -gpu_id 01234567
   ```

2. Once the run is complete, refer to the bottom of the terminal for performance numbers. The run will show the ns/day for the number of cores that were run.


## Post-processing

For post-processing, you can use Visual Molecular Dynamics (VMD) software to analyze the models.
Run the following commands to configure VMD:
```
./configure
cd src
sudo make install
```

If you are using vnc, launch vncserver and create a vnc password as follows:
```
sudo systemctl start vncserver@:1.service
sudo systemctl enable vncserver@:1.service
vncserver
vncpasswd
```

Start up a vnc connection using localhost:5901 (ensure tunneling is configured), and run the following commands to start up VMD:
```
vmd
```

Open the pdb files of your models and start analyzing!
