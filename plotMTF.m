function plotMTF(mtf,Fk)
    plot(Fk,mtf);
    xlim([0 1]);
    ax = gca;
    ax.FontSize = 16;
    ax.FontName = 'Arial';
    xlabel('Spatial Frequency (cycles/pixel)')
    ylabel('Modulation Transfer Function')
    axis square
    grid minor
end