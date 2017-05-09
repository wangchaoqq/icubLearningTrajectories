function drawInferenceRescaled(promp, infTraj, test,s_ref)
list = {'x[m]','y[m]','z[m]','f_x[N]','f_y[N]','f_z[N]', 'm_x[Nm]','m_y[Nm]','m_z[Nm]'};

nbInput = promp{1}.traj.nbInput;
set(0,'DefaultLineLinewidth',1)
set(0,'DefaultAxesFontSize',12)

%Plot the total trial and the data we have
nameFig = figure;
for vff=1:nbInput(1);
    subplot(nbInput(1),1,vff);


    i = infTraj.reco;%reco{1};
    visualisationShared(promp{i}.PHI_norm*promp{i}.mu_w, promp{i}.PHI_norm*1.96*sqrt(diag(promp{i}.sigma_w )), sum(nbInput), s_ref,  vff, 'b', nameFig);
    nameFig = visualisation(promp{i}.PHI_norm*promp{i}.mu_w, sum(nbInput), s_ref, vff, 'b', nameFig);
    prevG = size(nameFig,2);
    visualisationShared(promp{i}.PHI_norm*infTraj.mu_w, promp{i}.PHI_norm*1.96*sqrt(diag(infTraj.sigma_w)), sum(nbInput), s_ref,  vff,'r', nameFig);
%    visualisationShared(promp{i}.PHI_norm*infTraj.mu_w, promp{i}.PHI_norm*1.96*sqrt(diag(infTraj.sigma_w)), sum(nbInput), s_ref,  vff,'r', nameFig);
%    visualisationShared(promp{i}.PHI_norm*infTraj.mu_w, promp{i}.PHI_norm*1.96*sqrt(diag(infTraj.sigma_w)), sum(nbInput), s_ref,  vff,'r', nameFig);

    nameFig = visualisation(promp{i}.PHI_norm*infTraj.mu_w, sum(nbInput), s_ref, vff, 'r', nameFig);
    newG = size(nameFig,2);
    nameFig = visualisation2(test.yMat,sum(nbInput), test.totTime,vff, ':k', s_ref / test.totTime, nameFig);hold on;
    dtG = size(nameFig,2);
    nameFig(size(nameFig,2) + 1) = plot(test.partialTraj(1+ test.nbData*(vff-1):(infTraj.timeInf/s_ref):test.nbData + test.nbData*(vff-1)),'ok','linewidth',3);
    dnG = size(nameFig,2);
    
    ylabel(list{vff}, 'fontsize', 24);
         
%            switch vff
%                case 1: axis([-0.35 -0.25 0 100]);
%                case 2: asis([-0.1 0 0 100]);
%                case 3: axis([-0.1 0.2]);
%            end
           if(vff==nbInput(1))
              xlabel('Normalized #samples', 'fontsize', 24);
         end
         set(gca, 'fontsize', 20)
         
end
legend(nameFig(1,[dtG, dnG, prevG, newG]),'real trajectory', 'observations','prior proMP', 'prediction', 'Location', 'northwest' );
end