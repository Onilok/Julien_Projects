
<html>
    <body>
        <h1>Users Page</h1>
        <br>
        <ul>
            <?php $__currentLoopData = $Bubbles; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $bubble): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                <li><?php echo e($bubble->bubble_name); ?></li>
            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
        </ul>
    </body>
</html>



<?php /**PATH /home/molok/git/Bubble_my_tea/Bubble_My_tea/resources/views/bubble.blade.php ENDPATH**/ ?>